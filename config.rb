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

class ZapContentLength < Struct.new(:app)
  def call(env)
    s, h, b = app.call(env)
    # The URL rewriters in Middleman do not update Content-Length correctly,
    # which makes Rack-Lint flag the responses as having a wrong Content-Length.
    # For building assets this has zero importance because the Content-Length
    # header will be discarded - it is the server that recomputes it. But
    # it does prevent the site from building correctly.
    #
    # The fastest way out of this is to let Rack recompute the Content-Length
    # forcibly, for every response, at retrieval time.
    #
    # See https://github.com/middleman/middleman/issues/2309
    # and https://github.com/rack/rack/issues/1472
    h.delete('Content-Length')
    [s, h, b]
  end
end

app.use ::Rack::ContentLength
app.use ZapContentLength
