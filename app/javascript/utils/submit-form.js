export default function submitForm(url, formDataObj, csrfTokenMetaName = 'csrf-token') {
    const formData = new FormData();

    // Populate FormData
    Object.entries(formDataObj).forEach(([key, value]) => {
        formData.append(key, value);
    });

    // Fetch with CSRF token
    return fetch(url, {
        method: 'POST',
        headers: {
            'X-CSRF-Token': document.querySelector(`meta[name="${csrfTokenMetaName}"]`).content,
            Accept: "application/json",
        },
        body: formData,
    });
}
