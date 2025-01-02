<script setup>
import Logo from "../../../assets/images/docroll-logo.png"
import ButtonToggle from "./ToggleFullscreen.vue";
import {ref} from "vue"
import toggleFullscreen from "../../utils/toggle-fullscreen.js";

defineProps({
  subChapters: {
    type: Array,
    required: true,
    default: [
      "Prerequisites", "Creating Your First Rails App", "Directory Structure", "Model-View-Controller Basics"]
  },
  chapterIndex: {
    type: Number || String,
    required: true,
    default: 3
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
      <ol class=" ">
        <li v-for="(subChapter, i) in subChapters" :key="i" class="font-serif text-2xl font-semibold text-left mb-4">
          <span class="font-normal mr-3">{{ chapterIndex + '.' }}{{ i + 1 }}</span>{{ subChapter }}
        </li>
      </ol>
    </div>
  </div>
</template>

<style scoped>

</style>
