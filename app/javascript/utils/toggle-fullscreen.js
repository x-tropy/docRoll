export default function toggleFullscreen(el) {
    if (document.fullscreenElement) {
        document.exitFullscreen()
    } else {
        el.requestFullscreen()
    }
}
