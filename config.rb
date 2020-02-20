WEBPACK_CLI = "./node_modules/webpack-cli/bin/cli.js".freeze

configure :build do
  activate :asset_hash
  activate :minify_css
  activate :minify_javascript
end

activate :relative_assets
activate :directory_indexes
activate :livereload
activate :external_pipeline,
  name: :webpack,
  command: (build? ? "NODE_ENV=production #{WEBPACK_CLI} --mode=production" : "NODE_ENV=development #{WEBPACK_CLI} --watch --mode=development"),
  source: "./dist",
  latency: 1

ignore "javascript/*"

helpers do
  def icon(name)
    content_tag :svg, class: "icon" do
      content_tag :use, nil, href: image_path("icons.svg##{name}")
    end
  end
end
