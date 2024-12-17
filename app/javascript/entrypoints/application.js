import {createApp} from "vue";
import Hello from "../components/Hello.vue"
import Home from "../components/home/Root.vue"

console.log('Vite ⚡️ Rails')

const app = createApp(Hello)
app.mount(document.querySelector("#app"))

const appHome = createApp(Home)
appHome.mount(document.querySelector("#home"))
