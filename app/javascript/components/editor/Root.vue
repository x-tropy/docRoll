<script setup>
import Toolbar from "../ui/Toolbar.vue";
import Courses from "../editor/Courses.vue";
import Sections from "../editor/Sections.vue";
import Slides from "../editor/Slides.vue";
import Templates from "./Templates.vue"
import PcPlayMedia from "../icons/pc-play-media.vue";
import Divider from "../icons/space-divider.vue";
import Canvas from "../icons/canvas.vue";
import Layout25 from "../icons/layout-25.vue";
import {computed, ref} from "vue";

const items = [
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
  }, {
    label: "Templates",
    icon: Layout25,
    action: "templates"
  },
]

const activeTabName = ref("courses")
const activeTabIndex = computed(() => {
  const tabs = items.map(el => el.action)
  return tabs.indexOf(activeTabName.value)
})
const courseId = ref(null)

function activateTab(action) {
  activeTabName.value = action
}

function gotoSections(id) {
  courseId.value = id
  activateTab('sections')
}

function gotoCourses() {
  activateTab('courses')
}
</script>

<template>
  <Toolbar class="fixed top-5 right-16" :items="items" :currentItem="true" :activeTabIndex="activeTabIndex"
           @switch-tab="activateTab"/>
  <Courses v-if="activeTabName == 'courses'" @goto-sections="gotoSections"/>
  <Sections v-if="activeTabName == 'sections'" :courseId="courseId" @goto-courses="gotoCourses"/>
  <Slides v-if="activeTabName == 'slides'"/>
  <Templates v-if="activeTabName == 'templates'"/>

</template>

<style scoped>

</style>
