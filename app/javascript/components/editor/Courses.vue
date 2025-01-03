<script setup>
import docrollLogo from "../../../assets/images/docroll-logo.png"
import WindowParagraph from "@/components/icons/window-paragraph.vue";
import Link from "@/components/icons/link.vue";
import {onBeforeMount, ref} from "vue";
import submitForm from "@/utils/submit-form.js";
import CRemove from "@/components/icons/c-remove.vue";
import mist from "../../../assets/images/mist.png"
import ICircle from "@/components/icons/i-circle.vue";

const sourceUrl = ref("")
const invalidUrl = ref(false)
const courses = ref([])
const emit = defineEmits(['goto-sections'])

function fetchDoc() {
  if (!sourceUrl.value.includes("github.com")) {
    invalidUrl.value = true
    return
  }
  const rawUrl = sourceUrl.value
    .replace("https://github.com/", "https://raw.githubusercontent.com/")
    .replace("/blob", "");

  fetch(rawUrl)
    .then(response => {
      if (!response.ok) {
        invalidUrl.value = true
        throw new Error(`Failed to fetch: ${response.status} ${response.statusText}`);
      }
      invalidUrl.value = false
      sourceUrl.value = ""
      return response.text(); // Extract the text content
    })
    .then(data => {
      submitForm('/courses', 'POST', {
        "raw": data,
        "link": sourceUrl.value
      }).then(resp => {
        if (resp.ok) {
          //   redirect to sections tab
        }
      })
    })
    .catch(error => {
      console.error("Error fetching the file:", error);
    });
}

onBeforeMount(() => {
  fetch("/courses").then(resp => {
    if (resp.ok) {
      return resp.json()
    } else {
      console.log(resp)
    }
  })
    .then(data => courses.value = data)
})
</script>

<template>
  <div class="text-center mt-20">
    <a href="/" class=" inline-block ">
      <img class=" h-14" :src="docrollLogo"/>
    </a>
  </div>
  <div class="flex justify-center mt-10">
    <div class="relative">
      <Link color="rgb(156 163 175)" class="absolute text-gray-400 top-[14px] left-4"/>
      <input v-model="sourceUrl" class="input border-gray-400 w-[500px] mr-2 pl-11" placeholder="paste document's link here"
             type="text"/>
    </div>
    <button class="btn btn-secondary btn-lg" @click="fetchDoc">
      <WindowParagraph class="h-3.5"/>
      <span>Fetch doc</span>
    </button>
  </div>
  <p v-if="invalidUrl" class="text-red-500 flex justify-center gap-1 items-center text-sm mt-5">
    <CRemove color="rgb(239 68 68)"/>
    Only GitHub README.md is supported currently.
  </p>
  <ul class="grid grid-cols-3 m-10 pb-10 gap-5">
    <li @click="emit('goto-sections', course.id)" v-for="(course, i) in courses" class="col-span-1 bg-gray-200 aspect-[16/9] bg-cover rounded-lg hover:shadow-md transition-all hover:-translate-y-2 cursor-pointer"
        :style="`background-image: url(${mist})`" :key="i">
      <div class="bg-white bg-opacity-45 backdrop-blur h-full flex flex-col">
        <div class="flex justify-between text-xs pl-3 pr-2 py-2 items-center text-gray-500">
          <span class="">{{ course.productionDate || "19 December, 2024" }}</span>
          <div class="rounded-full bg-gray-600 text-white bg-opacity-50 pr-2 pl-1 py-0.5 flex items-center gap-1">
            <ICircle class="h-3" color="#fff"/>
            <span>{{ course.courseTitle || "Editing" }}</span></div>
        </div>
        <div class="flex-grow flex justify-center items-center">
          <h2 class="font-serif text-2xl mb-7 text-center font-bold">{{ course.courseTitle || "Getting Started with Rails" }}</h2>
        </div>
      </div>
    </li>
  </ul>
</template>

<style scoped>

</style>
