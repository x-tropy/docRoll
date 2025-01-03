export default function () {
    const codeElements = Array.from(document.querySelectorAll("pre code"))
    codeElements.forEach(el => {
        // avoid duplicate rendering
        if (el.previousElementSibling?.classList.contains('code-language-label')) return

        const language = el.className.match(/language-(\w+)/)[1];
        if (language) {
            const label = document.createElement('span');
            label.textContent = language;
            label.classList.add('code-language-label');
            el.parentNode.insertBefore(label, el);
        }
    })
}
