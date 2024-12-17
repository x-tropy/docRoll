<template><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" :width="width" :height="height"><title>{{title}}</title><g :fill="fill"><path d="M8,0a8,8,0,1,0,8,8A8.024,8.024,0,0,0,8,0Zm2.765,8.424-4,2.5A.5.5,0,0,1,6.5,11a.5.5,0,0,1-.5-.5v-5a.5.5,0,0,1,.765-.424l4,2.5a.5.5,0,0,1,0,.848Z" :fill="fill"></path></g></svg></template>

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
		title: {
			type: String,
			default: "circle caret right"
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