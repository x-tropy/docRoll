<template><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" :width="width" :height="height"><g :fill="fill"><path d="M14,10a1,1,0,0,0-1,1v2H3V11a1,1,0,0,0-2,0v2a2,2,0,0,0,2,2H13a2,2,0,0,0,2-2V11A1,1,0,0,0,14,10Z" :fill="fill"></path><path d="M7.293,10.707a1,1,0,0,0,1.414,0l4-4a1,1,0,1,0-1.414-1.414L9,7.586V2A1,1,0,0,0,7,2V7.586L4.707,5.293A1,1,0,0,0,3.293,6.707Z" :fill="_secondaryfill"></path></g></svg></template>

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