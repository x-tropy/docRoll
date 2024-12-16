import {createApp} from "vue";
import Hello from "../components/Hello.vue"

console.log('Vite ⚡️ Rails')

const app = createApp(Hello)
app.mount(document.querySelector("#app"))
