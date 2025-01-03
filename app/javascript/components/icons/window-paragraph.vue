<template>
  <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16"><title>{{title}}</title>
    <g :fill="color">
      <path :fill="color" d="M5,7H1C0.4,7,0,6.6,0,6V2c0-0.6,0.4-1,1-1h4c0.6,0,1,0.4,1,1v4C6,6.6,5.6,7,5,7z"></path>
      <rect x="8" y="1" :fill="color" width="8" height="2"></rect>
      <rect x="8" y="5" :fill="color" width="8" height="2"></rect>
      <rect y="9" :fill="color" width="16" height="2"></rect>
      <rect y="13" :fill="color" width="16" height="2"></rect>
    </g>
  </svg>
</template>

<script>
export default {
  props: {
    title: {
      type: String,
      default: "window paragraph"
    },
    color: {
      type: String,
      default: "#fff"
    }
  }
}
</script>
