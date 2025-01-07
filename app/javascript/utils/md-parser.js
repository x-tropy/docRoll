import {Marked, marked} from "marked";
import {markedHighlight} from "marked-highlight";
import hljs from 'highlight.js';
import 'highlight.js/styles/github.css';

export const createMarkedInstance = () => {
    return new Marked(markedHighlight({
        emptyLangClass: 'hljs', langPrefix: 'hljs language-', highlight(code, lang, info) {
            const language = hljs.getLanguage(lang) ? lang : 'plaintext';
            return hljs.highlight(code, {language}).value;
        }
    }));
};

export function markdownToSections(str) {
    const tokens = marked.lexer(str);
    const result = [];
    let cache = ''

    tokens.forEach((token) => {
        switch (token.type) {
            case 'space':{
                if (!cache) return
                cache += token.raw
                return
            }
            case 'heading': {
                // headers serve as separator
                if (cache) {
                    result.push({
                        raw: cache,
                        role: 'body'
                    })
                    cache = ''
                }

                // continue processing with header
                result.push({
                    raw: token.text,
                    role: 'h'+token.depth
                });
                return
            }
            case 'hr': {
                // hr also serves as separator
                if (!cache) return
                result.push({
                    raw: cache,
                    role: 'body'
                })
                cache = ''
                return
            }
            default: {
                cache += token.raw
            }
        }
    });
    return result
}
