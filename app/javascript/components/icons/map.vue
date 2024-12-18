<template><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" :width="width" :height="height"><g :fill="fill"><path d="M14.6,0.1L10,1.9L6.4,0.1C6.2,0,5.9,0,5.6,0.1l-5,2C0.2,2.2,0,2.6,0,3v12c0,0.7,0.7,1.2,1.4,0.9L6,14.1 l3.6,1.8c0.3,0.1,0.5,0.1,0.8,0l5-1.9c0.4-0.1,0.6-0.5,0.6-0.9V1C16,0.3,15.3-0.2,14.6,0.1z M7,2.6l2,1v9.8l-2-1V2.6z M2,3.7l3-1.2 v9.8l-3,1.2V3.7z M14,12.4l-3,1.1V3.7l3-1.2V12.4z" :fill="fill"></path></g></svg></template>

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