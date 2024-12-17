<template><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" :width="width" :height="height"><title>{{title}}</title><g :fill="fill"><path d="M9.5,8H8V9.5a.5.5,0,0,1-.5.5h-1A.5.5,0,0,1,6,9.5V8H4.5A.5.5,0,0,1,4,7.5v-1A.5.5,0,0,1,4.5,6H6V4.5A.5.5,0,0,1,6.5,4h1a.5.5,0,0,1,.5.5V6H9.5a.5.5,0,0,1,.5.5v1A.5.5,0,0,1,9.5,8Z" :fill="_secondaryfill"></path><path d="M7,14a7,7,0,1,1,7-7A7.008,7.008,0,0,1,7,14ZM7,2a5,5,0,1,0,5,5A5.006,5.006,0,0,0,7,2Z" :fill="fill"></path><path d="M15.707,14.293,13.314,11.9A8.019,8.019,0,0,1,11.9,13.314l2.393,2.393a1,1,0,0,0,1.414-1.414Z" :fill="_secondaryfill"></path></g></svg></template>

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
			default: "search zoom in"
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