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
    let body = ''

    tokens.forEach((token) => {
        switch (token.type) {
            case 'space':{
                if (!body) return
                body += token.raw
                return
            }
            case 'heading': {
                // headers serve as separator
                if (body) {
                    result.push({
                        raw: body
                    })
                    body = ''
                }

                // continue processing with header
                result.push({
                    text: token.text,
                    depth: token.depth
                });
                return
            }
            case 'hr': {
                // hr also serves as separator
                if (!body) return
                result.push({
                    raw: body
                })
                body = ''
                return
            }
            default: {
                body += token.raw
            }
        }
    });
    return result
}
