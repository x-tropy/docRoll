export function longDate(str) {
    const date = str ? new Date(str) : new Date()
    return date.toLocaleDateString('en-US', {
        day: 'numeric',
        month: 'long',
        year: 'numeric'
    })
}
