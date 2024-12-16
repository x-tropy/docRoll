/** @type {import('tailwindcss').Config} */
export default {
    content: [
        "./app/assets/stylesheets/**/*.css",
        "./app/views/**/*.{html,html.erb,erb}",
        "./app/javascript/components/**/*.vue",
    ],
    theme: {
        extend: {
            fontFamily: {
                serif: ["SourceSerifPro"],
                sans: ["Inter"],
                mono: ["JetBrainsMono"],
            }
        },
    },
    plugins: [],
}
