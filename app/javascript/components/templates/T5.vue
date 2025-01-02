<script setup>
import Logo from "../../../assets/images/docroll-logo.png"
import ToggleFullscreen from "./ToggleFullscreen.vue";
import {ref} from "vue"
import toggleFullscreen from "../../utils/toggle-fullscreen.js";
import 'highlight.js/styles/github.css'

defineProps({
  indicator: {
    type: String,
    required: true,
    default: "1. Introduction"
  },
  imgUrl: {
    type: String,
    required: true,
    default: "https://placehold.co/600x400"
  },
  pageNumber: {
    type: Number || String,
    required: true,
    default: 13
  }
})

const frame = ref(null)


</script>

<template>
  <div class="frame" ref="frame">
  <ToggleFullscreen @toggle-fullscreen="toggleFullscreen(frame)"/>
    <div class="header">
      <span class="indicator">{{ indicator }}</span>
      <img class="logo" :src="Logo"/>
    </div>
    <div class="content">
      <div class="h-full">
        <img :src="imgUrl" class="h-full mx-auto"/>
      </div>
      <span class="absolute text-sm font-semibold bottom-0 right-0 rounded-br-xl rounded-tl-xl bg-white px-2 py-0.5">{{
          pageNumber
        }}</span>
    </div>
  </div>
</template>

<style scoped></style>
