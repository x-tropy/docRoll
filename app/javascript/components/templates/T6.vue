<script setup>
import Logo from "../../../assets/images/docroll-logo.png"
import partyPopper from "../../../assets/images/party-popper.png"
import ButtonToggle from "./ToggleFullscreen.vue";
import {ref} from "vue"
import toggleFullscreen from "../../utils/toggle-fullscreen.js";

defineProps({
  sourceUrl: {
    type: String,
    required: false,
  }
})
const frame = ref(null)

</script>

<template>
  <div class="frame" ref="frame">
    <ButtonToggle @toggle-fullscreen="toggleFullscreen(frame)"/>
    <div class="header flex-row-reverse pt-1">
      <img class="logo" :src="Logo"/>
    </div>
    <div class="h-full flex flex-col items-center justify-center">
      <img class="h-20 mb-4" :src="partyPopper"/>
      <h1 class="font-serif text-4xl font-bold mb-8">Thanks for Watching!</h1>
      <p>For more information, visit source document:</p>
      <p class="w-[400px] text-blue-400 underline break-all text-center"><a :href="sourceUrl">{{sourceUrl}}</a></p>
    </div>
    <div class="text-right mb-3">
      <p class="p-2 text-white inline-block bg-black bg-opacity-50 rounded">✨ Turn doc into animated video: <a
        class="underline text-blue-200 pr-1" href="https://docroll.fly.dev">https://docroll.fly.dev</a></p>
    </div>
  </div>
</template>

<style scoped>

</style>
