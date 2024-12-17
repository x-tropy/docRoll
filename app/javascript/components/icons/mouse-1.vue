<template><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" :width="width" :height="height"><title>{{title}}</title><g :fill="fill"><path d="M8,4A.945.945,0,0,0,7,5V7A.945.945,0,0,0,8,8,.945.945,0,0,0,9,7V5A.945.945,0,0,0,8,4Z" :fill="_secondaryfill"></path><path d="M8,0A6.006,6.006,0,0,0,2,6v4a6,6,0,0,0,12,0V6A6.006,6.006,0,0,0,8,0Zm4,10a4,4,0,0,1-8,0V6a4,4,0,0,1,8,0Z" :fill="fill"></path></g></svg></template>

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
			default: "mouse 1"
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