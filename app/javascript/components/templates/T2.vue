<script setup>
import Logo from "../../../assets/images/docroll-logo.png"
import ButtonToggle from "./ToggleFullscreen.vue";
import {ref} from "vue"
import toggleFullscreen from "../../utils/toggle-fullscreen.js";

defineProps({
  chapterTitle: {
    type: String,
    required: true,
    default: "Getting Started with Rails"
  },
  chapterIndex: {
    type: Number || String,
    required: true,
    default: 3
  },
  subtitle: {
    type: String
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
      <h1 class="font-serif text-4xl text-center mb-4">§ {{ chapterIndex }}</h1>
      <h1 class="font-serif text-4xl font-bold mb-16">{{ chapterTitle }}</h1>
    </div>
    <div v-if="subtitle !== ''" class="subtitle-container">
      <p class="subtitle">{{ subtitle}}</p>
    </div>
  </div>
</template>

<style scoped>

</style>
