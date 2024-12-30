export default function submitForm(url, requestType, formDataObj, csrfTokenMetaName = 'csrf-token') {
    let formData

    if (formDataObj) {
        formData = new FormData();

        // Populate FormData
        Object.entries(formDataObj).forEach(([key, value]) => {
            formData.append(key, value);
        });
    }

    // Fetch with CSRF token
    return fetch(url, {
        method: requestType,
        headers: {
            'X-CSRF-Token': document.querySelector(`meta[name="${csrfTokenMetaName}"]`).content,
            Accept: "application/json",
        },
        body: formData,
    });
}
