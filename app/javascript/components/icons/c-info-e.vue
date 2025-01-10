<template><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" :width="width" :height="height"><g :fill="fill"><path d="M8,0a8,8,0,1,0,8,8A8.024,8.024,0,0,0,8,0ZM8,14a6,6,0,1,1,6-6A6.018,6.018,0,0,1,8,14Z" :fill="fill"></path><rect x="7" y="7" width="2" height="5" rx="0.5" :fill="_secondaryfill"></rect><circle cx="8" cy="5" r="1" :fill="_secondaryfill"></circle></g></svg></template>

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