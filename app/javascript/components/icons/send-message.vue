<template><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" :width="width" :height="height"><g :fill="fill"><path d="M15.707,.293c-.273-.272-.68-.365-1.043-.234L.664,5.059C.287,5.193,.026,5.54,.002,5.939c-.024,.4,.192,.775,.551,.955l4.586,2.292,4.641-3.314c.23-.164,.513,.119,.349,.349l-3.315,4.642,2.292,4.586c.171,.339,.518,.552,.895,.552,.021,0,.041-.001,.061-.002,.4-.024,.747-.284,.882-.662L15.943,1.336c.129-.363,.037-.77-.236-1.043Z" :fill="fill"></path></g></svg></template>

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