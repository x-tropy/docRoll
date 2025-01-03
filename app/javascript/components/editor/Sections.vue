<script setup>
import {computed, nextTick, onMounted, ref, watch} from "vue"
import BlankState from "@/components/ui/BlankState.vue";
import PcPlayMedia from "@/components/icons/pc-play-media.vue";
import {createMarkedInstance} from "@/utils/md-parser.js";
import ArrowTopRight from "@/components/icons/arrow-top-right.vue";
import Divider from "@/components/icons/space-divider.vue";
import {debounce} from "lodash-es";
import submitForm from "../../utils/submit-form.js"

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

onMounted(async () => {
  try {
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
    // course name
    title.value = sectionsContainer.value.querySelector('h1').innerText

    // toc
    const headings = sectionsContainer.value.querySelectorAll('h1, h2, h3, h4, h5')
    toc.value = JSON.stringify(
      Array.from(headings).map(heading => ({
        level: parseInt(heading.tagName[1]),
        text: heading.textContent
      })),
      null, 2
    )
  })
}, 300)

async function handleSubmit() {
  const response = await submitForm("/courses/" + props.courseId, "PATCH", {
    'title': title.value,
    'production_date': productionDate.value,
    'author': author.value,
    'link': link.value,
    'raw': raw.value,
    'toc': toc.value
  })

  if (response.ok) {
    console.log(response)
  }
}


watch((raw) => {
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
    <BlankState class="mt-14 mb-6" title="Divide into Sections" color="blue"
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
            <input type="text" class="input w-full" placeholder="example: 17 December, 2024" v-model="productionDate"/>
          </div>
          <div class="col-span-2">
            <p class="label required">Course Name</p>
            <input type="text" class="input w-full" placeholder="input course name" v-model="title"/>
          </div>
        </div>
        <button @click="handleSubmit" class="my-5 sticky top-5 btn btn-md btn-secondary z-20">
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16"><title>send-message</title>
            <g fill="#fff">
              <path
                d="M15.707,.293c-.273-.272-.68-.365-1.043-.234L.664,5.059C.287,5.193,.026,5.54,.002,5.939c-.024,.4,.192,.775,.551,.955l4.586,2.292,4.641-3.314c.23-.164,.513,.119,.349,.349l-3.315,4.642,2.292,4.586c.171,.339,.518,.552,.895,.552,.021,0,.041-.001,.061-.002,.4-.024,.747-.284,.882-.662L15.943,1.336c.129-.363,.037-.77-.236-1.043Z"
                fill="#fff"></path>
            </g>
          </svg>
          Submit Changes
        </button>

        <!--        parsedMarkdown-->
        <div ref="sectionsContainer"
             class="article !w-full !py-3  !m-0 section-divider px-4 border-8 border-gray-300 rounded-xl"
             v-html="parsedMarkdown"></div>

        <!--        toc-->
        <p class="label mt-6">Table of Contents (auto-generated)</p>
        <textarea type="text" disabled rows="5" class="input w-full" v-model="toc"/>
      </div>
    </div>
  </div>
</template>
