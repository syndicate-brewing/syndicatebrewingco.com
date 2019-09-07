activate :sprockets
sprockets.append_path "node_modules"

configure :build do
  activate :asset_hash, ignore: /syndicate-icon/
  activate :minify_css
end
