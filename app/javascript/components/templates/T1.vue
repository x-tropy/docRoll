<script setup>
import Logo from "../../../assets/images/docroll-logo.png"
import ButtonToggle from "./ToggleFullscreen.vue";
import {ref} from "vue"
import toggleFullscreen from "../../utils/toggle-fullscreen.js";
import {longDate} from "@/utils/format-date.js";

defineProps({
  productionDate: {
    type: String,
    default: longDate()
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
  <div class="bg-mist relative px-16 py-14 mx-auto" ref="frame">
    <ButtonToggle @toggle-fullscreen="toggleFullscreen(frame)"/>
    <div class="flex justify-between">
      <img class="inline-block h-7" :src="Logo"/>
      <span class="font-serif text-xl">{{ longDate(productionDate) }}</span>
    </div>
    <div class="absolute bottom-16">
      <span class="font-serif text-xl inline-block mb-4">{{ author }} / Course</span>
      <h1 class="font-serif text-5xl font-bold">{{ courseTitle }}</h1>
    </div>
  </div>
</template>

<style scoped>

</style>
