<script setup>
import {computed, nextTick, onMounted, ref, watch} from "vue"
import BlankState from "@/components/ui/BlankState.vue";
import PcPlayMedia from "@/components/icons/pc-play-media.vue";
import {createMarkedInstance, markdownToSections} from "@/utils/md-parser.js";
import ArrowTopRight from "@/components/icons/arrow-top-right.vue";
import Divider from "@/components/icons/space-divider.vue";
import {debounce} from "lodash-es";
import submitForm from "../../utils/submit-form.js"
import SendMessage from "@/components/icons/send-message.vue";
import CircleAnim from "@/components/icons/circle-anim.vue";
import CCheck from "@/components/icons/c-check.vue";

const props = defineProps({
  courseId: {
    type: Number || String,
    required: true
  }
})

const marked = createMarkedInstance()

const emit = defineEmits(['goto-courses'])
const title = ref('')
const productionDate = ref('')
const author = ref('')
const link = ref('')
const raw = ref('')
const toc = ref('')
const isLoading = ref(false)
const error = ref(null)
const parsedMarkdown = ref('')

// status for submit button style
const submitting = ref(false)
const submitSuccess = ref(false)

onMounted(async () => {
  try {
    // check courseId
    if (typeof parseInt(props.courseId) !== "number") {
      console.log("courseId invalid", props.courseId)
      return
    }

    isLoading.value = true
    const response = await fetch('/courses/' + props.courseId)

    if (response.ok) {
      const courseDetail = await response.json()
      console.log({courseDetail})
      productionDate.value = courseDetail.production_date
      link.value = courseDetail.link
      title.value = courseDetail.title
      author.value = courseDetail.author
      raw.value = courseDetail.raw
      toc.value = courseDetail.toc
    }
  } catch (err) {
    error.value = err
  } finally {
    isLoading.value = false
  }
})

const sectionsContainer = ref(null)

const updateParsedMarkdown = debounce(() => {
  parsedMarkdown.value = marked.parse(raw.value)
  nextTick(() => {
    // course title
    if (title.value === "" || title.value === null) {
      title.value = sectionsContainer.value.querySelector("h1")?.innerText
    }

    // toc
    const headings = Array.from(sectionsContainer.value.querySelectorAll('h2, h3'))
    const result = []
    let chapterIndex = 0

    headings.forEach(heading => {
      if (heading.tagName === 'H2') {
        chapterIndex++
        result[chapterIndex - 1] = {
          chapterIndex: chapterIndex,
          chapterTitle: heading.textContent,
          subChapters: []
        }
      } else if (heading.tagName === 'H3') {
        result[chapterIndex - 1].subChapters.push(heading.textContent)
      }
    })

    toc.value = JSON.stringify(result, null, 2)
  })
}, 300)

async function handleSubmit() {
  submitting.value = true

  const response = await submitForm("/courses/" + props.courseId, "PATCH", {
    'title': title.value,
    'production_date': productionDate.value,
    'author': author.value,
    'link': link.value,
    'raw': raw.value,
    'toc': toc.value
  })

  if (response.ok) {
    console.log("course is submitted successfully!")
  }

  // store this array in Sections table
  const sections = markdownToSections(raw.value)
  const response2 = await submitForm("/sections", "POST", {
    course_id: props.courseId,
    sections: sections
  })

  if (response2.ok) {
    console.log("sections are submitted successfully!")
    submitSuccess.value = true
    setTimeout(() => submitSuccess.value = false, 6000)
  }

  submitting.value = false
}


watch((raw) => {
  // if sectionsContainer is not mounted yet
  if (!sectionsContainer.value) return

  updateParsedMarkdown()
})


</script>

<template>
  <div v-if="courseId === null" class="justify-center h-full flex flex-col">
    <BlankState title="Select a Course First" color="orange"
                body="To begin dividing your document into sections, please select a course first. Click the <b>Select Course</b> button to proceed.">
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
  <div v-else>
    <BlankState class="pt-14 mb-6" title="Divide into Sections" color="blue"
                body="docroll has automatically divided the source document into sections. Customize it by adding or removing &ldquo;---&rdquo; to <b>create</b> or <b>merge</b> sections as needed.">
      <template #icon>
        <Divider strokewidth="2" width="28" height="28" class="drop-shadow-lg text-white"/>
      </template>
    </BlankState>

    <div v-if="isLoading">Loading...</div>
    <div v-else-if="error">Error loading sections.</div>
    <div v-else class="grid grid-cols-2 gap-5 p-5">
      <!--      markdown editor-->
      <div class="relative h-full">
        <p class="label required">Markdown Editor</p>
        <a :href="link" target="_blank"
           class="btn btn-sm btn-primary w-fit absolute -top-1 right-0 bg-opacity-50 hover:bg-opacity-100">Source
          Document
          <ArrowTopRight class="h-3" color="#fff"/>
        </a>

        <textarea class="input w-full h-full whitespace-pre-wrap bg-white leading-tight" @input="updateParsedMarkdown"
                  v-model="raw"/>
      </div>
      <div>
        <div class="grid grid-cols-2 gap-5">
          <div>
            <p class="label required">Author</p>
            <input type="text" class="input w-full" placeholder="input your name" v-model="author"/>
          </div>
          <div>
            <p class="label required">Production Date</p>
            <input type="text" class="input w-full" placeholder="example: 2025-01-15" v-model="productionDate"/>
          </div>
          <div class="col-span-2">
            <p class="label required">Course Name</p>
            <input type="text" class="input w-full" placeholder="input course name" v-model="title"/>
          </div>
        </div>
        <div class="flex items-center gap-4">
          <button @click="handleSubmit" class="my-5 sticky top-5 btn btn-md btn-primary z-20 " :class="{'disabled':submitting}" :disabled="submitting">
            <CircleAnim v-if="submitting" class="h-4" />
            <SendMessage v-else class="h-4"/>
            {{ submitting ? "Submitting..." : "Submit Changes" }}
          </button>
          <div v-if="submitSuccess" class="flex gap-1 items-center">
            <CCheck class="h-4 text-green-500" />
            <span class="text-green-500">Sections are created!</span>
<!--            <button class="ml-4 btn btn-sm btn-primary">Proceed to Slides -></button>-->
          </div>
        </div>

        <!--        parsedMarkdown-->
        <div ref="sectionsContainer"
             class="article bg-white !w-full !py-3  !m-0 section-divider px-4 border-8 border-cyan-100 rounded-xl"
             v-html="parsedMarkdown"></div>

        <!--        toc-->
        <p class="label mt-6">Table of Contents (auto-generated)</p>
        <textarea type="text" disabled rows="5" class="input w-full" v-model="toc"/>
      </div>
    </div>
  </div>
</template>
