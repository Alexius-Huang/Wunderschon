# Wunderschön

[![MIT Licence](https://badges.frapsoft.com/os/mit/mit.svg?v=103)](https://opensource.org/licenses/mit-license.php) [![Build Status](https://travis-ci.org/Maxwell-Alexius/Wunderschon.svg?branch=master)](https://travis-ci.org/Maxwell-Alexius/Wunderschon) [![Code Climate](https://codeclimate.com/github/Maxwell-Alexius/Wunderschon/badges/coverage.svg)](https://codeclimate.com/github/Maxwell-Alexius/Wunderschon/coverage)

[![Ruby on Rails](https://img.shields.io/badge/Ruby_on_Rails-5.1.1-red.svg?style=flat
)](http://rubyonrails.org) [![Ruby](https://img.shields.io/badge/Ruby-4.2.1-red.svg?style=flat)](http://rubyonrails.org)


[![forthebadge](http://forthebadge.com/images/badges/made-with-ruby.svg)](http://forthebadge.com) [![forthebadge](http://forthebadge.com/images/badges/built-with-love.svg)](http://forthebadge.com)

![Wunderschön Rabbit](https://github.com/Maxwell-Alexius/Wunderschon/blob/master/README_Images/root_page.png?raw=true)

## About

**Wunderschön** means **very gorgeous and wonderful** in German. This project is a kind of online shopping website which is filled with sketches of rabbits and its products.

**Wunderschön** is built with **[Ruby](https://www.ruby-lang.org/en/)** version 2.4.1 and **[Rails 5.1](http://rubyonrails.org/)**.

## JS Asset Pipeline with Webpacker & Yarn

Using Rails 5.1+ provided new feature: **[Loving Javascript](http://weblog.rubyonrails.org/2017/4/27/Rails-5-1-final/)** integrate with **[Yarn](https://yarnpkg.com/en/)** JS dependencies management. You can think of Yarn as the JS version of the bundler.

### Setting Up Webpacker

1. Add gem [`webpacker`](https://github.com/rails/webpacker) to the `Gemfile` and execute `bundle install`

```ruby
  gem 'webpacker'
```
```
$ bundle install
```

2. **Remember to check and update your [`NodeJS`](https://nodejs.org/en/) version! (>= 6.4.0)**

```
$ node -v
```

3. After install the gem, `webpacker` provide several rake tasks. To check it, run `bin/rails webpacker` you should get the following output:

```
$ bin/rails webpacker
Available webpacker tasks are:
webpacker:install                Installs and setup webpack with yarn
webpacker:compile                Compiles webpack bundles based on environment
webpacker:check_node             Verifies if Node.js is installed
webpacker:check_yarn             Verifies if yarn is installed
webpacker:check_webpack_binstubs Verifies that bin/webpack & bin/webpack-dev-server are present
webpacker:verify_install         Verifies if webpacker is installed
webpacker:yarn_install           Support for older Rails versions. Install all JavaScript dependencies as specified via Yarn
webpacker:install:react          Installs and setup example React component
webpacker:install:vue            Installs and setup example Vue component
webpacker:install:angular        Installs and setup example Angular component
webpacker:install:elm            Installs and setup example Elm component
```

4. Choose an installation command, e.g. if want to install with `React`, run 

```
$ bundle exec rake webpacker:install:react
```

5. After `webpacker` installed, you can put your ES6 JS files in the `app/javascript` directory. This is where the `webpacker` compiles your JS file.

6. Run the command below to compile the JS files. The compiled files will be placed in `public/packs` directory.

```
$ bundle exec webpacker:compile
```

7. `webpacker` gem provide helper method `javascript_pack_tag` for loading JS files in your views. For instance, to load the compiled `application.js` in `application.html.erb`, in your view:

```erb
<html>
  <head>
    <!-- ... Other Stylesheet or Meta Tags ... -->

    <%= javascript_include_tag 'application', 'data-turbolinks-track': 'reload' %>
    <!-- Load compiled application.js -->
    <%= javascript_pack_tag    'application' %>
  </head>
  ...
```

For more information, you can read:
- [`webpacker` Gem Github](https://github.com/rails/webpacker)
- [Embracing Change: Rails 5.1 Adopts Yarn, Webpack, and the JS Ecosystem](http://pixelatedworks.com/articles/embracing-change-rails51-adopts-yarn-webpack-and-the-js-ecosystem/)
- [Introducing Webpacker](https://medium.com/statuscode/introducing-webpacker-7136d66cddfb)

### Develop with `foreman`

`foreman` can help us manage to execute rails server with `webpacker` watch mode at the same time. Install the gem first, but *not to include in your project Gemfile!*

```
$ gem install foreman
```

Create the `Procfile` in the app root directory and add the content:

```
web: bundle exec rails server
webpacker: ./bin/webpack-dev-server
```

Running the command will start the rails server and start the `webpacker` watch mode:

```
$ foreman start
```

For more information, see **[`foreman` gem GitHub](https://github.com/ddollar/foreman)**
### Using Yarn

It is very easy to use Yarn, similar to node package manager, initialize Yarn first:

```
$ yarn init
```

Use the command to install node package:

```
$ yarn add [package-name]
```

Take Wunderschön (a.k.a. this project) for example, to install [`rxjs`](https://github.com/ReactiveX/rxjs), run:

```
$ yarn add rxjs
```

Check the `node_modules` directory, you can see that the bundled and minified Rx.js file is located in `node_modules/rxjs/bundles/Rx.min.js`. We can then include the JS file in the `application.html.erb`:

```js
//= require rxjs/bundles/Rx.min.js
```
