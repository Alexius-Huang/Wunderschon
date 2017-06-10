# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
css_files = %w(
  navbar.scss
  category/show.scss
  backend.scss
  backend/navbar.scss
  backend/products.scss
  backend/categories.scss
)
js_files = %w(
  rabbit.js
  categories.js
  backend.js
  backend/categories.js
  backend/products.js
)
Rails.application.config.assets.precompile += css_files
Rails.application.config.assets.precompile += js_files
