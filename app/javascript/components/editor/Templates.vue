<script setup>
import submitForm from "../../utils/submit-form.js"
import {onBeforeMount, ref} from "vue";
import T1 from "../templates/T1.vue"
import T4 from "../templates/T4.vue"
import T2 from "../templates/T2.vue"
import T5 from "../templates/T5.vue"
import T3 from "../templates/T3.vue"
import T6 from "../templates/T6.vue"
import TemplateForm from "./TemplateForm.vue";
import IAdd from "@/components/icons/i-add.vue";

const templates = ref(null)
const openFormId = ref(null)

onBeforeMount(async () => {
  const response = await fetch("/templates")
  templates.value = await response.json()
})


const templateComponents = {
  T1, T2, T3, T4, T5,T6
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
  <ul class="m-20">
    <TemplateForm v-if="openFormId == -1" :index="null" method="POST" @close-form="closeForm"/>
    <div v-else class="flex flex-row-reverse">
      <button class="btn btn-secondary btn-md" @click="openFormId = -1">
        <IAdd class="h-4"/>
        <span>Create new template</span></button>
    </div>
    <li v-for="(t, i) in templates" key="i" class="my-10">
      <div v-if="openFormId != t.id">

        <!--        template information-->
        <ul class="mb-2 pt-10 border-t-2 border-gray-300 pb-5">
          <li v-for="(entry, j) in Object.keys(t)" key="j" class="grid grid-cols-4">
            <span class="font-medium">{{ entry }}</span> <span class="col-span-2">{{ t[entry] }}</span>

            <!--        actions-->
            <div v-if="j==0" class="flex flex-row-reverse gap-2">
              <a class="btn btn-danger btn-sm" @click="deleteEntry(t.id, i)">Delete</a>
              <a class="btn btn-secondary btn-sm" @click="openForm(t.id)">Edit</a>
            </div>
          </li>
        </ul>

        <!--        template preview-->
        <component :is="templateComponents[t.name]" v-if="Object.keys(templateComponents).includes(t.name)"/>
      </div>
      <TemplateForm v-else method="PATCH" :index="i" :template="t" @close-form="closeForm"/>
    </li>
  </ul>
</template>

<style scoped>

</style>
