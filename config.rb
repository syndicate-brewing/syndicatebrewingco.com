activate :sprockets
sprockets.append_path "node_modules"

configure :build do
  activate :minify_css
end
