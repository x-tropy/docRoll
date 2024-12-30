import {createApp} from "vue";
import Hello from "../components/Hello.vue"
import Home from "../components/home/Root.vue"
import Transcription from "../components/player/Transcription.vue";
import TemplateForm from "../components/editor/TemplateForm.vue";
import ListTemplates from "../components/editor/Templates.vue"

const app = createApp(Hello)
app.mount(document.querySelector("#app"))

const appHome = createApp(Home)
appHome.mount(document.querySelector("#home"))

const transcriptionDiv = document.querySelector('#transcription')
if (transcriptionDiv) {
    const appTranscription = createApp(Transcription, {
        transcription: transcriptionDiv.getAttribute("transcription")
    })
    appTranscription.mount(transcriptionDiv)
}
