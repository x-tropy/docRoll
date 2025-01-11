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
import SendMessage from "@/components/icons/send-message.vue";
import Soundwave from "@/components/icons/soundwave.vue";

const templateComponents = {T1, T2, T3, T4, T5, T6}

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
const currentTemplateName = ref('')
const availableSlots = computed(() => {
  return templates.value.find(t => t[0] === currentTemplateName.value)?.[1] || '(none)'
})
const slideIndex = ref(0)
const textForDisplay = computed(() => {
  if (slides.value.length > 0)
    return JSON.parse(slides.value[slideIndex.value].text_for_display)
})
const slidesNotFound = ref(false)
const textForVoiceover = ref('')

onMounted(async () => {
  // check course id
  if (typeof parseInt(props.courseId) !== 'number') {
    console.log("courseId is invalid", props.courseId)
    return
  }

  const resp = await fetch(`/courses/${props.courseId}/slides`)
  if (resp.ok) {
    const data = await resp.json()
    if (data.slides.length === 0) slidesNotFound.value = true
    console.log(data.slides)
    slides.value = data.slides
    templates.value = data.templates
    currentTemplateName.value = slides.value[slideIndex.value]?.template_name
  }
})
</script>

<template>
  <!--  error state-->
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
        <button class="btn-primary btn btn-md mt-2" @click="emit('goto-sections', courseId)">
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

  <!--  normal state-->
  <div v-else class="flex flex-row h-full">
    <ul class=" mt-16 overflow-y-auto text-gray-600 overflow-x-hidden ">
      <li
        class="w-[40px] py-2 m-1.5 font-mono  text-sm font-black bg-gray-200 select-none hover:shadow-md hover:bg-white hover:text-cyan-400 hover:bg-gray-200 text-center rounded  hover:cursor-pointer "
        v-for="i in range(0, slides.length)"
        :class="{ '!bg-gray-600 shadow-md text-cyan-300 hover:bg-gray-600': slideIndex === i }" @click="slideIndex = i">
        {{ i + 1 }}
      </li>
    </ul>

    <!--    form fields-->
    <div v-if="slides.length > 0" class="w-[460px] pt-2 px-3 mt-16 overflow-auto flex flex-col gap-5">
      <div>
        <p class="label required">Template</p>
        <select class="input pr-10 w-full" v-model="currentTemplateName">
          <option v-for="(arr, i) in templates" :key="i" :value="arr[0]">{{ arr[0] }}</option>
        </select>
        <p class="text-sm mt-2">Available slots: <span class="font-mono text-cyan-400">{{ availableSlots }}</span></p>
      </div>
      <div>
        <p class="label required">Prompt</p>
        <textarea class="input w-full" placeholder="prompt for generating voiceover text and slide text" rows="5"
                  v-model="slides[slideIndex].prompt"></textarea>
        <button class="btn btn-primary btn-md">
          <SendMessage class="h-4"/>
          Send Prompt
        </button>
      </div>
      <div>
        <p class="label required">Text for voiceover</p>
        <textarea class="input w-full" rows="5" placeholder="used to generate voice file (.mp3)"
                  v-model="textForVoiceover"></textarea>
        <button class="btn btn-primary btn-md">
          <Soundwave class="h-4"/>
          Generate Voice
        </button>
      </div>
      <div class="mb-10">
        <hr class="h-0.5 mb-5 bg-gray-300"/>
        <button class="btn justify-center btn-primary w-full btn-md">
          <SendMessage class="h-4"/>
          Submit Changes
        </button>
      </div>
    </div>

    <!--    template components-->
    <div v-if="slides.length > 0" class=" p-4 pt-[70px] overflow-auto flex-grow">
      <component :is="templateComponents[currentTemplateName]"
                 :author="textForDisplay.author"
                 :indicator="slides[slideIndex].indicator"
                 :courseTitle="textForDisplay.courseTitle"
                 :pageNumber="slides[slideIndex].page_number"
                 :productionDate="textForDisplay.productionDate"
                 :sourceUrl="textForDisplay.sourceUrl"
                 :body="textForDisplay.body"
                 :chapterIndex="textForDisplay.chapterIndex"
                 :chapterTitle="textForDisplay.chapterTitle"
      />
    </div>
  </div>
</template>
<style scoped></style>
