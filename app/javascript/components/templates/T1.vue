<script setup>
import Logo from "../../../assets/images/docroll-logo.png"
import ToggleFullscreen from "./ToggleFullscreen.vue";
import {ref} from "vue"
import toggleFullscreen from "../../utils/toggle-fullscreen.js";

defineProps({
  productionDate: {
    type: String,
    default: new Date().toLocaleDateString('en-US', {
      day: 'numeric',
      month: 'long',
      year: 'numeric'
    })
  },
  author: {
    type: String,
    default: "docroll"
  },
  courseTitle: {
    type: String,
    required: true,
    default: "Getting Started with Rails"
  }
})

const frame = ref(null)

</script>

<template>
  <div class="bg-mist mx-auto relative px-16 py-14" ref="frame">
    <ToggleFullscreen @toggle-fullscreen="toggleFullscreen(frame)"/>
    <div class="flex justify-between">
      <img class="inline-block h-7" :src="Logo"/>
      <span class="font-serif text-xl">{{ productionDate }}</span>
    </div>
    <div class="absolute bottom-16">
      <span class="font-serif text-xl inline-block mb-4">{{ author }} / Course</span>
      <h1 class="font-serif text-4xl font-bold">{{ courseTitle }}</h1>
    </div>
  </div>
</template>

<style scoped>

</style>
