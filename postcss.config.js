const purgecss = require("@fullhuman/postcss-purgecss")({
  content: ["./source/**/*.erb"],
  defaultExtractor: content => (content.match(/[\w-/:]+(?<!:)/g) || [])
});

module.exports = {
  plugins: [
    require("postcss-import"),
    require("tailwindcss"),
    ...(process.env.NODE_ENV === "production" ? [purgecss] : [])
  ]
};