activate :sprockets
sprockets.append_path "node_modules"

configure :build do
  activate :asset_hash
  activate :minify_css
end
