<template><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" :width="width" :height="height"><g :fill="fill"><path d="M15,0H1C0.448,0,0,0.448,0,1v9c0,0.552,0.448,1,1,1h2.882l-1.776,3.553 c-0.247,0.494-0.047,1.095,0.447,1.342C2.696,15.966,2.849,16,2.999,16c0.367,0,0.72-0.202,0.896-0.553L4.618,14h6.764l0.724,1.447 C12.281,15.798,12.634,16,13.001,16c0.15,0,0.303-0.034,0.446-0.105c0.494-0.247,0.694-0.848,0.447-1.342L12.118,11H15 c0.552,0,1-0.448,1-1V1C16,0.448,15.552,0,15,0z M5.618,12l0.5-1h3.764l0.5,1H5.618z M14,9H2V2h12V9z" :fill="fill"></path></g></svg></template>

<script>
export default {
	props: {
		width: {
			type: [Number, String],
			default: "1em"
		},
		height: {
			type: [Number, String],
			default: "1em"
		},
		strokewidth: {
			type: [Number, String],
			default: 1
		},
		fill: {
			type: String,
			default: "currentColor"
		},
		secondaryfill: {
			type: String
		}
	},
	computed: {
		_secondaryfill: function () {
			return this.secondaryfill || this.fill
		}
	}
}
</script>