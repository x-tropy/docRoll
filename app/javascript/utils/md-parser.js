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

    tokens.forEach((token, index) => {
        // finishing up current body
        if (token.type === "heading" || token.type === "hr") {
            if (cache) {
                result.push({
                    raw: cache,
                    role: 'body'
                })
                cache = ''
            }
        }

        // main logic
        if (token.type === "heading") {
            if (token?.depth <= 3) { // process with major headers
                result.push({
                    raw: token.text,
                    role: 'h' + token.depth
                });
            } else { // other headers should be part of body
                cache += token.raw
            }
        } else if (token.type === "space") {
            // side effect: ignore preceding spaces
            if (cache) {
                cache += token.raw
            }
        } else { // all others should be part of body
            cache += token.raw
        }

        // if this is the last one
        if (index === tokens.length - 1) {
            result.push({
                raw: cache,
                role: 'body'
            })
        }
    });
    return result
}
