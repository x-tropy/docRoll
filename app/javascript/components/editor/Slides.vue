<script setup>
import {computed, onMounted, onUnmounted, ref, watch} from "vue";
import BlankState from "@/components/ui/BlankState.vue";
import PcPlayMedia from "@/components/icons/pc-play-media.vue";
import SpaceDivider from "@/components/icons/space-divider.vue";
import CircleAnim from "@/components/icons/circle-anim.vue";
import {range} from "lodash-es";
import T1 from "../templates/T1.vue"
import T4 from "../templates/T4.vue"
import T2 from "../templates/T2.vue"
import T5 from "../templates/T5.vue"
import T3 from "../templates/T3.vue"
import T6 from "../templates/T6.vue"
import SendMessage from "@/components/icons/send-message.vue";
import Soundwave from "@/components/icons/soundwave.vue";
import submitForm from "@/utils/submit-form.js";
import ButtonPlay from "@/components/icons/button-play.vue";

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
const availableSlots = computed(() => {
  return templates.value.find(t => t[0] === slides.value[slideIndex.value].template_name)?.[1] || '(none)'
})
const parsedTextForDisplay = computed(() => {
  if (slides.value.length > 0)
    return JSON.parse(slides.value[slideIndex.value].text_for_display)
})
const slidesNotFound = ref(false)
const slideIndex = ref(0)

// Voiceover related
const textForVoiceover = ref("")
const audioUrl = ref('')
const subtitles = ref([])
const audioRef = ref(null)

const sendingPrompt = ref(false)
const sendPrompt = async () => {
  console.log({
    "general_prompt": slides.value[slideIndex.value].prompt,
    "input_object": slides.value[slideIndex.value].text_for_display,
  })
  sendingPrompt.value = true
  const resp = await submitForm("/slides/generate", "POST", {
    "general_prompt": slides.value[slideIndex.value].prompt,
    "input_object": slides.value[slideIndex.value].text_for_display,
  })
  if (resp.ok) {
    const data = await resp.json()
    console.log(data)
    textForVoiceover.value = data.text_for_voiceover
    if (data.body && parsedTextForDisplay.value.body) {
      parsedTextForDisplay.value.body = data.body
    }
  }
  sendingPrompt.value = false
}

const changeSlide = i => {
  slideIndex.value = i
  textForVoiceover.value = slides.value[slideIndex.value].text_for_voiceover
}

const generatingVoice = ref(false)
const generateVoice = async () => {
  generatingVoice.value = true
  const body = {
    'voiceover[text]': textForVoiceover.value,
    'voiceover[slide_id]': slides.value[slideIndex.value].id
  }
  console.log(body)
  const resp = await submitForm("voiceovers", "POST", body)
  if (resp.ok) {
    const data = await resp.json()
    console.log(data)
    audioUrl.value = data.audio_url
    subtitles.value = data.subtitles
  } else {
    console.log(resp)
  }
  generatingVoice.value = false
}

const submitting= ref(false)
const save = async () => {
  submitting.value = true
  const body = {
    "slide[text_for_display]": parsedTextForDisplay.value,
    "slide[text_for_voiceover]": textForVoiceover.value,
    "slide[prompt]": slides.value[slideIndex.value].prompt
  }

  const resp = await submitForm("slides/" + slides.value[slideIndex.value].id, "PATCH", body)
  if (resp.ok) {
    const data = await resp.json()
    slides.value[slideIndex.value].text_for_voiceover = textForVoiceover.value
    console.log(data)
  } else {
    console.log(resp)
  }
  submitting.value = false
}

const playVoiceover = () => {
  if (!audioRef.value) return

  if (audioRef.value.paused) {
    audioRef.value.play()
  } else {
    audioRef.value.pause()
  }
}

const lastCheckedTime = ref(0)
const currentSubtitle = ref('')
const updateSubtitle = () => {
  if (!audioRef.value) return

  const currentTime = audioRef.value.currentTime
  if (Math.abs(currentTime - lastCheckedTime.value) < 0.5) {
    return
  }

  lastCheckedTime.value = currentTime

  const subtitle = subtitles.value.find(sub =>
    currentTime >= sub.start_time && currentTime <= sub.end_time
  )

  currentSubtitle.value = subtitle ? subtitle.text : ''
}

watch(audioRef, newVal => {
  newVal.addEventListener('timeupdate', updateSubtitle)
})

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
    slides.value = data.slides
    textForVoiceover.value = slides.value[slideIndex.value].text_for_voiceover
    templates.value = data.templates
  }
})

onUnmounted(() => {
  if (audioRef.value) {
    audioRef.value.removeEventListener('timeupdate', updateSubtitle)
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
        :class="{ '!bg-gray-600 shadow-md text-cyan-300 hover:bg-gray-600': slideIndex === i }" @click="changeSlide(i)">
        {{ i + 1 }}
      </li>
    </ul>

    <!--    form fields-->
    <div v-if="slides.length > 0" class="w-[460px] pt-2 px-3 mt-16 overflow-auto flex flex-col gap-5">
      <div>
        <p class="label required">Template (can't change)</p>
        <select class="input pr-10 w-full" disabled v-model="slides[slideIndex].template_name">
          <option v-for="(arr, i) in templates" :key="i" :value="arr[0]">{{ arr[0] }}</option>
        </select>
        <p class="text-sm mt-2">Available slots: <span class="font-mono text-cyan-400">{{ availableSlots }}</span></p>
      </div>
      <div>
        <p class="label required">Prompt</p>
        <textarea class="input w-full" placeholder="prompt for generating voiceover text and slide text" rows="5"
                  v-model="slides[slideIndex].prompt"></textarea>
        <button @click="sendPrompt" class="btn btn-primary btn-md" :class="{'disabled':sendingPrompt}"
                :disabled="sendingPrompt">
          <CircleAnim v-if="sendingPrompt" class="h-4"/>
          <SendMessage v-else class="h-4"/>
          {{ sendingPrompt ? "Sending..." : "Send Prompt" }}
        </button>
      </div>
      <div>
        <p class="label required">Text for Display</p>
        <textarea class="input w-full" rows="5" placeholder="used to control content display"
                  :value="JSON.stringify(parsedTextForDisplay, null, 2)"></textarea>
      </div>
      <div>
        <p class="label required">Text for Vsoiceover</p>
        <textarea class="input w-full" rows="5" placeholder="used to generate voice file (.mp3)"
                  v-model="textForVoiceover"></textarea>
        <div class="flex justify-between">
          <button @click="generateVoice" class="btn btn-primary btn-md" :class="{'disabled':generatingVoice}"
                  :disabled="generatingVoice">
            <CircleAnim v-if="generatingVoice" class="h-4"/>
            <Soundwave v-else class="h-4"/>
            {{ generatingVoice ? "Generating..." : "Generate Voice" }}
          </button>
          <button @click="playVoiceover" class="btn btn-primary btn-md">
            <ButtonPlay class="h-4"/>
            Preview
          </button>
        </div>
        <div v-if="audioUrl">
          <audio ref="audioRef" class="w-full" controls>
            <source :src="audioUrl" type="audio/mpeg">
          </audio>
        </div>
      </div>
      <div class="mb-6">
        <hr class="h-0.5 mb-5 bg-gray-300"/>
        <button @click="save" class="btn justify-center btn-primary w-full btn-md" :class="{'disabled':submitting}" :disabled="submitting">
          <CircleAnim v-if="submitting" class="h-4" />
          <SendMessage v-else class="h-4"/>
          {{submitting ? "Submitting..." : "Submit Changes"}}
        </button>
      </div>
    </div>

    <!--    template components-->
    <div v-if="slides.length > 0" class=" p-4 pt-[70px] overflow-auto flex-grow">
      <component :is="templateComponents[slides[slideIndex].template_name]"
                 :author="parsedTextForDisplay.author"
                 :indicator="slides[slideIndex].indicator"
                 :courseTitle="parsedTextForDisplay.courseTitle"
                 :pageNumber="slides[slideIndex].page_number"
                 :productionDate="parsedTextForDisplay.productionDate"
                 :sourceUrl="parsedTextForDisplay.sourceUrl"
                 :body="parsedTextForDisplay.body"
                 :chapterIndex="parsedTextForDisplay.chapterIndex"
                 :chapterTitle="parsedTextForDisplay.chapterTitle"
                 :subtitle="currentSubtitle"
      />
    </div>
  </div>
</template>
<style scoped></style>
