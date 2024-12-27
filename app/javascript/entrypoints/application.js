import {createApp} from "vue";
import Hello from "../components/Hello.vue"
import Home from "../components/home/Root.vue"
import Transcription from "@/components/player/Transcription.vue";

console.log('Vite ⚡️ Rails')

const app = createApp(Hello)
app.mount(document.querySelector("#app"))

const appHome = createApp(Home)
appHome.mount(document.querySelector("#home"))

const transcriptionDiv = document.querySelector('#transcription')
const appTranscription = createApp(Transcription, {
    transcription: transcriptionDiv.getAttribute("transcription")
})
appTranscription.mount(transcriptionDiv)
