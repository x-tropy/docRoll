<script setup>
import {onMounted, ref} from "vue";
import html2canvas from "html2canvas";
import domtoimage from "dom-to-image"
import Map from "@/components/icons/map.vue";
import Mist from "../../../assets/images/mist.jpg"

const props = defineProps({
  transcription: {
    type: String,
    required: true
  }
})

const jsonObject = JSON.parse(props.transcription)

const characters = jsonObject.characters
const character_start_times_seconds = jsonObject.character_start_times_seconds
const character_end_times_seconds = jsonObject.character_end_times_seconds
console.log({characters})

const words = characters.map((item, index) => {
  if (item === " ") {
    return index
  }
  return null
}).filter(item => !!item).map(item => {
  return character_start_times_seconds[item]
})

const temp = characters.map((item, index) => {
  if (item === "," || item === ".") {
    return index
  }
  return null
}).filter(item => !!item).map(item => {
  return character_start_times_seconds[item]
})

const segments = [0, ...temp, character_end_times_seconds.at(-1)]
const durations = segments.slice(1).map((item, i) => item - segments[i])

const screenshot = ref('')

function toImage() {
  const target = document.querySelector("#target")
  // html2canvas(target).then(canvas => {
  //   screenshot.value = canvas.toDataURL('image/png')
  // })
  domtoimage.toPng(target, {
    height: target.offsetHeight * 2,
    style: {
      transform: `scale(${2}) translate(${target.offsetWidth / 2 / 2}px, ${target.offsetHeight / 2 / 2}px)`
    },
    width: target.offsetWidth * 2
  })
      .then(dataUrl => screenshot.value = dataUrl)
}
</script>

<template>
  <button class="btn btn-md btn-primary" @click="toImage">Capture</button>
  <img :src="screenshot"/>
  <div id="target" class="bg-white">
    <button class="btn btn-md flex items-center gap-2 mt-2 btn-primary">
      <Map/>
      <span>Capture</span>
    </button>
    <div class="mt-2 relative">
      <img :src="Mist" class="w-[400px]"/>
      <div class="rounded bg-white bg-opacity-50 m-4 absolute w-3/4 h-3/4 top-0"></div>
    </div>
    <hr class="h-1 my-5"/>
    <h2 class="font-semibold text-lg">Word Transcription</h2>
    <pre class="w-full overflow-scroll"><code>{{ words }}</code></pre>

    <hr class="h-1 my-5"/>
    <h2 class="font-semibold text-lg">Segment Transcription</h2>
    <pre class="w-full overflow-auto"><code>{{ segments }}</code></pre>

    <hr class="h-1 my-5"/>
    <h2 class="font-semibold text-lg">Durations</h2>
    <pre class="w-full overflow-auto"><code>{{ durations }}</code></pre>
  </div>
</template>

<style scoped>

</style>
