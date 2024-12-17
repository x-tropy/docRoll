<template><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" :width="width" :height="height"><title>{{title}}</title><g :fill="fill"><path d="M15,9c-.6,0-1,.4-1,1v4H2V2H6c.6,0,1-.4,1-1s-.4-1-1-1H2C.895,0,0,.895,0,2V14c0,1.105,.895,2,2,2H14c1.105,0,2-.895,2-2v-4c0-.6-.4-1-1-1Z" :fill="fill"></path><path d="M13.854,.146c-.195-.195-.512-.195-.707,0L6.146,7.146c-.055,.055-.097,.122-.121,.195l-1,3c-.06,.18-.013,.378,.121,.512,.096,.095,.223,.146,.354,.146,.053,0,.106-.008,.158-.026l3-1c.073-.024,.141-.066,.195-.121L15.854,2.854c.195-.195,.195-.512,0-.707L13.854,.146Z" :fill="_secondaryfill"></path></g></svg></template>

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
			default: "n edit"
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