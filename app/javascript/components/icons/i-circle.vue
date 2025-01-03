<template>
  <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16"><title>{{title}}</title>
    <g :fill="color">
      <path d="M8,16a8,8,0,1,1,8-8A8.009,8.009,0,0,1,8,16ZM8,2a6,6,0,1,0,6,6A6.006,6.006,0,0,0,8,2Z" :fill="color"
            opacity="0.4"></path>
      <path d="M16,8H14A6.006,6.006,0,0,0,8,2V0A8.009,8.009,0,0,1,16,8Z" :fill="color"></path>
    </g>
  </svg>
</template>

<script>
export default {
  props: {
    title: {
      type: String,
      default: "l circle"
    },
    color: {
      type: String,
      default: "#000"
    }
  }
}
</script>
