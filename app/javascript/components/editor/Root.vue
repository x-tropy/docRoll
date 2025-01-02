<script setup>
import Toolbar from "../ui/Toolbar.vue";
import Courses from "../editor/Courses.vue";
import Sections from "../editor/Sections.vue";
import Slides from "../editor/Slides.vue";
import Templates from "./Templates.vue"
import PcPlayMedia from "../icons/pc-play-media.vue";
import Divider from "../icons/divider.vue";
import Canvas from "../icons/canvas.vue";
import Layout25 from "../icons/layout-25.vue";
import {ref} from "vue";

const items = [
  {
    label: "Templates",
    icon: Layout25,
    action: "templates"
  },
  {
    label: "Courses",
    icon: PcPlayMedia,
    divideRight: true,
    action: "courses"
  }, {
    label: "Sections",
    icon: Divider,
    divideRight: true,
    action: "sections"
  }, {
    label: "Slides",
    icon: Canvas,
    divideRight: true,
    action: "slides"
  },
]

const activeTabName = ref("templates")

function executeTool(action) {
  activeTabName.value = action
}
</script>

<template>
  <Toolbar class="fixed top-5 right-16" :items="items" :currentItem="true" currentItemIndex="0"
           @tool-event="executeTool"/>
  <Courses v-if="activeTabName == 'courses'"/>
  <Sections v-if="activeTabName == 'sections'"/>
  <Slides v-if="activeTabName == 'slides'"/>
  <Templates v-if="activeTabName == 'templates'"/>

</template>

<style scoped>

</style>
