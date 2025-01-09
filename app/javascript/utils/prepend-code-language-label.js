export default function () {
    const codeElements = Array.from(document.querySelectorAll("pre code"))
    codeElements.forEach(el => {
        // avoid duplicate rendering
        if (el.previousElementSibling?.classList.contains('code-language-label')) return

        const matches = el.className.match(/language-(\w+)/);
        if (matches === null) return;

        const language = matches[1]
        if (language) {
            const label = document.createElement('span');
            label.textContent = language;
            label.classList.add('code-language-label');
            el.parentNode.insertBefore(label, el);
        }
    })
}
