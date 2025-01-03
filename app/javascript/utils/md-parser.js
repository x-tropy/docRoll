import {Marked} from "marked";
import {markedHighlight} from "marked-highlight";
import hljs from 'highlight.js';
import 'highlight.js/styles/github.css';

export const createMarkedInstance = () => {
    return new Marked(
        markedHighlight({
            emptyLangClass: 'hljs',
            langPrefix: 'hljs language-',
            highlight(code, lang, info) {
                const language = hljs.getLanguage(lang) ? lang : 'plaintext';
                return hljs.highlight(code, {language}).value;
            }
        })
    );
};
