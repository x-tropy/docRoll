<template><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" :width="width" :height="height"><g :fill="fill"><path d="M8,16a1,1,0,0,1-1-1V1A1,1,0,0,1,9,1V15A1,1,0,0,1,8,16Z" :fill="fill"></path><path d="M5,13a1,1,0,0,1-1-1V4A1,1,0,0,1,6,4v8A1,1,0,0,1,5,13Z" :fill="_secondaryfill"></path><path d="M2,10A1,1,0,0,1,1,9V7A1,1,0,0,1,3,7V9A1,1,0,0,1,2,10Z" :fill="fill"></path><path d="M11,13a1,1,0,0,1-1-1V4a1,1,0,0,1,2,0v8A1,1,0,0,1,11,13Z" :fill="_secondaryfill"></path><path d="M14,10a1,1,0,0,1-1-1V7a1,1,0,0,1,2,0V9A1,1,0,0,1,14,10Z" :fill="fill"></path></g></svg></template>

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