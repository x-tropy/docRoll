<script setup>
import Logo from "../../../assets/images/docroll-logo.png"
import ToggleFullscreen from "./ToggleFullscreen.vue";
import {ref} from "vue"
import toggleFullscreen from "../../utils/toggle-fullscreen.js";
import {marked} from "marked"

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
  <div class="frame" ref="frame">
    <ToggleFullscreen @toggle-fullscreen="toggleFullscreen(frame)"/>
    <div class="header">
      <span class="date">{{ productionDate }}</span>
      <img class="logo" :src="Logo"/>
    </div>
    <div class="content">
      <div class="article"
           v-html="marked('# Marked \n## in browser\n\nRendered by *marked*. \n* a \n* b \n* c')"
      ></div>
    </div>
  </div>
</template>

<style scoped>

</style>
