<script setup>
import submitForm from "../../utils/submit-form.js"
import {onBeforeMount, ref} from "vue";
import T1 from "../templates/T1.vue"
import T2 from "../templates/T2.vue"
import TemplateForm from "@/components/editor/TemplateForm.vue";

const templates = ref(null)
const openFormId = ref(null)

onBeforeMount(async () => {
  const response = await fetch("/templates")
  templates.value = await response.json()
})


const templateComponents = {
  T1, T2
}

async function deleteEntry(id, i) {
  const response = await submitForm("/templates/" + id, "DELETE")
  if (response.ok) {
    templates.value.splice(i, 1)
    console.log(templates.value)
  }
}

function openForm(id) {
  openFormId.value = id
}

function closeForm(data) {
  openFormId.value = null
  if (data) {
    const {index, id, name, slots, description} = data
    if (index === null)
      templates.value.splice(0, 0, {name, id, slots, description})
    else
      templates.value.splice(index, 1, {name, id, slots, description})
  }
}

</script>

<!--
openFormId:
* -1 means creating new
* (others) means updating the existed

<TemplateForm />

method:
* POST
* PATCH

index:
* null
* i means the order of item in the list
-->

<template>
  <ul class="container">
    <TemplateForm v-if="openFormId == -1" :index="null" method="POST" @close-form="closeForm"/>
    <button v-else class="btn btn-primary btn-md" @click="openFormId = -1">New</button>
    <li v-for="(t, i) in templates" key="i" class="my-10">
      <div v-if="openFormId != t.id">
        <ul class="mb-2">
          <li v-for="(entry, j) in Object.keys(t)" key="j" class="flex justify-between">
            <span class="font-medium">{{ entry }}</span> <span>{{ t[entry] }}</span>
          </li>
        </ul>
        <div class="flex gap-2">
          <a class="btn btn-danger btn-sm" @click="deleteEntry(t.id, i)">Delete</a>
          <a class="btn btn-primary btn-sm" @click="openForm(t.id)">Edit</a>
        </div>
        <component :is="templateComponents[t.name]" v-if="Object.keys(templateComponents).includes(t.name)"/>
      </div>
      <TemplateForm v-else method="PATCH" :index="i" :template="t" @close-form="closeForm"/>
    </li>
  </ul>
</template>

<style scoped>

</style>
