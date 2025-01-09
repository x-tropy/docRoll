<script setup>
import {computed, onMounted, ref, watch} from "vue";
import BlankState from "@/components/ui/BlankState.vue";
import PcPlayMedia from "@/components/icons/pc-play-media.vue";
import SpaceDivider from "@/components/icons/space-divider.vue";
import {range} from "lodash-es";
import T1 from "../templates/T1.vue"
import T4 from "../templates/T4.vue"
import T2 from "../templates/T2.vue"
import T5 from "../templates/T5.vue"
import T3 from "../templates/T3.vue"
import T6 from "../templates/T6.vue"

const templateComponents = {
  T1, T2, T3, T4, T5, T6
}

const props = defineProps({
  courseId: {
    type: Number || String,
    required: true,
    default: null
  }
})

const emit = defineEmits(['goto-courses', 'goto-sections'])
const slides = ref([])
const templates = ref([])
const slideIndex = ref(0)
const textForDisplay = computed(() => {
  if (slides.value.length > 0)
    return JSON.parse(slides.value[slideIndex.value].text_for_display)
})
const slidesNotFound = ref(false)

onMounted(async () => {
  console.log(props.courseId)
  if (props.courseId === null) return
  const resp = await fetch(`/courses/${props.courseId}/slides`)
  const data = await resp.json()
  if (data.slides.length === 0) slidesNotFound.value = true
  slides.value = data.slides
  templates.value = data.templates
})
</script>

<template>
  <div v-if="courseId === null" class="justify-center h-full flex flex-col">
    <BlankState title="Select a Course First" color="orange"
                body="To edit slides, please select a course first. Click the <b>Select Course</b> button to proceed.">
      <template #icon>
        <PcPlayMedia strokewidth="2" width="28" height="28" class="drop-shadow-lg text-white"/>
      </template>
      <template #action>
        <button class="btn-primary btn btn-md mt-2" @click="emit('goto-courses')">
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">
            <title>arrow-left</title>
            <g fill="#fff">
              <path
                d="M15,7H3.414L6.707,3.707A1,1,0,0,0,5.293,2.293l-5,5a1,1,0,0,0,0,1.414l5,5a1,1,0,1,0,1.414-1.414L3.414,9H15a1,1,0,0,0,0-2Z"
                fill="#fff"></path>
            </g>
          </svg>
          Select Course
        </button>
      </template>
    </BlankState>
  </div>
  <div v-else-if="slidesNotFound" class="justify-center h-full flex flex-col">
    <BlankState title="Generate Sections First" color="orange"
                body="To edit slides, please generate sections first. Click the <b>Generate Sections</b> button to proceed.">
      <template #icon>
        <SpaceDivider strokewidth="2" width="28" height="28" class="drop-shadow-lg text-white"/>
      </template>
      <template #action>
        <button class="btn-primary btn btn-md mt-2" @click="emit('goto-sections')">
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">
            <title>arrow-left</title>
            <g fill="#fff">
              <path
                d="M15,7H3.414L6.707,3.707A1,1,0,0,0,5.293,2.293l-5,5a1,1,0,0,0,0,1.414l5,5a1,1,0,1,0,1.414-1.414L3.414,9H15a1,1,0,0,0,0-2Z"
                fill="#fff"></path>
            </g>
          </svg>
          Generate Sections
        </button>
      </template>
    </BlankState>
  </div>
  <div class="flex flex-row h-full">
    <ul class="w-[65px] mt-16 overflow-y-auto overflow-x-hidden bg-gray-200">
      <li
        class="w-[40px] py-2 m-1.5 font-mono text-sm font-black select-none hover:shadow-md hover:bg-white hover:text-cyan-400 hover:bg-gray-200 text-center rounded  hover:cursor-pointer "
        v-for="i in range(0, slides.length - 1)"
        :class="{'!bg-gray-600 shadow-md text-cyan-300 hover:bg-gray-600': slideIndex === i}"
        @click="slideIndex = i"
      >
        {{ i + 1 }}
      </li>
    </ul>
    <div class="w-[400px] pt-16 bg-white overflow-auto">
      <pre><code>{{ slides[slideIndex] }}</code></pre>
    </div>
    <div class="w-auto p-4 overflow-auto pt-16 flex-grow">
      <component :is="templateComponents[slides[slideIndex]?.template_name]"
                 :author="textForDisplay?.author"
                 :indicator="slides[slideIndex]?.indicator"
                 :pageNumber="slides[slideIndex]?.page_number"
                 :productionDate="textForDisplay?.productionDate"
                 :body="textForDisplay?.body"
                 :chapterIndex="textForDisplay?.chapterIndex"
                 :chapterTitle="textForDisplay?.chapterTitle"
      />
    </div>
  </div>
</template>
<style scoped>

</style>
