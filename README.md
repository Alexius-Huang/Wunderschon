# Wunderschön

[![MIT Licence](https://badges.frapsoft.com/os/mit/mit.svg?v=103)](https://opensource.org/licenses/mit-license.php) [![Build Status](https://travis-ci.org/Maxwell-Alexius/Wunderschon.svg?branch=master)](https://travis-ci.org/Maxwell-Alexius/Wunderschon) [![Code Climate](https://codeclimate.com/github/Maxwell-Alexius/Wunderschon/badges/coverage.svg)](https://codeclimate.com/github/Maxwell-Alexius/Wunderschon/coverage)

[![Ruby on Rails](https://img.shields.io/badge/Ruby_on_Rails-5.1.1-red.svg?style=flat
)](http://rubyonrails.org) [![Ruby](https://img.shields.io/badge/Ruby-4.2.1-red.svg?style=flat)](http://rubyonrails.org)

[![forthebadge](http://forthebadge.com/images/badges/made-with-ruby.svg)](http://forthebadge.com) [![forthebadge](http://forthebadge.com/images/badges/built-with-love.svg)](http://forthebadge.com)

![Wunderschön Rabbit](https://github.com/Maxwell-Alexius/Wunderschon/blob/master/README_Images/root_page.png?raw=true)

## About

**Wunderschön** means **very gorgeous and wonderful** in German. This project is a kind of online shopping website which is filled with sketches of rabbits and its products.

**Wunderschön** is built with **[Ruby](https://www.ruby-lang.org/en/)** version 2.4.1 and **[Rails 5.1](http://rubyonrails.org/)**.

## Requirement

- Ruby Version 4.2.1
- Rails Version 5.1.1
- NodeJS Version >= 6.4.0

## Installation & Setup

Clone It!

```
$ git clone git@github.com:Maxwell-Alexius/Wunderschon.git
```

Go into the project folder:

```
$ cd Wunderschon
```

Bundle it:

```
$ bundle install
```

Create and migrate database:

```
$ bundle exec rails db:create 
$ bundle exec rails db:migrate
```

If `yarn` haven't installed in your OS, see [installation of yarn](https://yarnpkg.com/lang/en/docs/install/). After yarn installed, run this command to install JS packages via yarn:

```
$ yarn init
```

You can choose to open Rails server and open `webpacker` (JS develop server) separately, that requires you to open additional two terminal and run two commands separately:

```
# Rails server
$ bundle exec rails server
```

```
# Webpacker JS develop server
$ ./bin/webpack-dev-server
```

Or you can integrate both server into a terminal via one command:

```
$ foreman start
```

It will automatically start both Rails server and JS webpacker develop server in the same terminal.

# Develop Notes

## Gems Info

Excluded the Rails default gems, the info of the included Ruby gems are listed below (in an alphabetical order):

- [`aasm`](https://github.com/aasm/aasm) - Perfect simulation of state machine
- [`awesome_print`](https://github.com/awesome-print/awesome_print) - Pretty print for Ruby objects with style in console
- [`bootstrap-sass`](https://github.com/twbs/bootstrap-sass) - Sass support for Bootstrap 2 and 3
- [`factory_girl_rails`](https://github.com/thoughtbot/factory_girl_rails) - Factory for producing records with different trait in a fast, easy and efficient way
- [`faker`](https://github.com/stympy/faker) - Generating fake data
- [`kaminari`](https://github.com/kaminari/kaminari) - An awesome pagination tool
- [`paranois`](https://github.com/rubysherpas/paranoia) - Prevention of hard destroy. In other words, *rather than deleting the data, it just hide it*.
- [`rails-controller-spec`](https://github.com/rails/rails-controller-testing) - For Rails controller tests with RSpec
- [`rspec-rails`](https://github.com/rspec/rspec-rails) - Brilliant testing framework for Rails
- [`rubocop`](https://github.com/bbatsov/rubocop) - Static Ruby code analyzer and syntax checker based on Ruby style guide 
- [`settingslogic`](https://github.com/binarylogic/settingslogic) - Simple, straightforward settings solution
- [`simple_form`](https://github.com/plataformatec/simple_form) - Namely, simple form parser
- [`shoulda-matchers`](https://github.com/thoughtbot/shoulda-matchers) - Testing matchers
- [`webpacker`](https://github.com/rails/webpacker) - An integration of JS webpack development with Rails

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

4. Choose an installation command, e.g. if you want to install with `React`, run 

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

Use the command to install any node package:

```
$ yarn add [package-name]
```

For example, adding `jquery` via yarn is simple:

```
$ yarn add jquery
```

Webpack prefers the original, unmodified source code of a library, rather than the packaged “dist” code. In Rails `config/webpack/shared.js`, add the `alias` key in the `resolve` object with an object which aliases the "jquery" with the directory of the jQuery file:

```js
// ... Omitted
module.exports = {
  // ... Omitted
  
  resolve: {
    alias: {
      jquery: 'jquery/src/jquery'
    },
    // ... Omitted
  }
}
```

In order to make jQuery available to other modules, we can use the **`webpack.ProvidePlugin` makes a module available as a variable in every other module required by webpack**. Therefore, in the same file, add the statement in the `plugins` part of the export module object:

```js
// ... Omitted
module.exports = {
  // ... Omitted
  
  plugins: [
    // Omitted
    new webpack.ProvidePlugin({
      $: 'jquery',
      jQuery: 'jquery',
      jquery: 'jquery'
    })
  ],

  // ... Omitted
}
```

Lastly, we can then require jQuery in the pack. Import jQuery into `app/javascript/packs/application.js` and make it available globally using the `window` object:

```js
import jQuery from 'jquery'
window.jQuery = jQuery
```

For more information, you can read:
- [`webpacker` Gem Github](https://github.com/rails/webpacker)
- [Embracing Change: Rails 5.1 Adopts Yarn, Webpack, and the JS Ecosystem](http://pixelatedworks.com/articles/embracing-change-rails51-adopts-yarn-webpack-and-the-js-ecosystem/)
- [Introducing Webpacker](https://medium.com/statuscode/introducing-webpacker-7136d66cddfb)

## Node Packages Info

- [`jQuery`](https://github.com/jquery/jquery) - Common but powerful JS library for fundamental DOM manipulations, events, traversal, animation and simple AJAX
- [`React.js`](https://facebook.github.io/react/) - Component based dynamic, reactive and declarative UI interface design
- [`axios`](https://github.com/mzabriskie/axios) - Promise based HTTP client for browser and NodeJS
- [`Rx.js`](https://github.com/ReactiveX/rxjs) - Powerful reactive programming with observable patterns implemented in JavaScript
- [`PIXI.js`](https://github.com/pixijs/pixi.js) - Super fast HTML 5 2D rendering engine that uses webGL with canvas fallback


## Using ReactJS in Rails with Webpacker
### Installation

Just run the webpacker built-in command and it'll serve you well:

```
$ bin/rails webpacker:install:react
```

It will automatically configure the `package.json`, `.babelrc` and install dependencies including the `babel-preset-react` which enables you to use `JSX` syntax during development.

Additionally, you should also install `prop-types` package using Yarn:

```
$ yarn add prop-types
```

Because [`React.PropTypes` is deprecated as of React version 15.5](https://facebook.github.io/react/warnings/dont-call-proptypes.html), so if you want to use `type checking` (and it is highly recommended), you should also install the `prop-types` library instead.

### Hello World Example

After installation, you can manage and develop React component in `app/javascript/packs/components/` directory. To create a component, for example, the `hello-world` program, create a new file called `hello-world.jsx` and below is the example code:

```jsx
import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

/* Declare Your Component */
class HelloWorld extends React.Component {
  constructor(props) {
    super(props)
    /* You can initialize your states here */
    // this.states = { ... }
  }

  static defaultProps = {
    appName: 'Hello World!'
  }; // <----- Do not forget the semicolon!

  /* You can declare life-cycle methods in this component declaration block */
  // componentWillMount() { ... }
  // componentDidMount() { ... }
  // shouldComponentReceiveProps() { ... }
  // ... other life-cycle methods

  render() {
    return (
      <div className="hello-world">
        {this.props.appName}
      </div>
    )
  }
}

/* Checking Props' Types */
HelloWorld.propTypes = {
  appName: PropTypes.string.isRequired
}

/* Render Your Component */
// You should have <div id="app"></div> in your HTML file
ReactDOM.render(
  <HelloWorld />,
  document.getElementById('app') 
)
```

### Nested Components

For example, to nest another component in our `HelloWorld` component, let's create another directory which is called `components/hello_world/` and include another component file `inner-component.jsx`. It should use the `export default` to **export our component as a module**:

```jsx
import React from 'react'
import PropTypes from 'prop-types'

class InnerComponent extends React.Component {
  constructor(props) {
    super(props)
  }

  render() {
    return (
      <div className="inner-component">
        Hello, This is the InnerComponent!
      </div>
    )
  }
}

export default InnerComponent
```

And then include the module to our root component file. Using JSX syntax to use the component in the `render` method:

```jsx
import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import InnerComponent from './hello_world/inner-component'

class HelloWorld extends React.Component {
  /* ... Omitted ... */
  render() {
    return (
      <div className="hello-world">
        <InnerComponent />
      </div>
    )
  }
}
```

### Using `props` to Transfer Date From Parent to Child Component
(Drafting...)

### Using `key` to Render List-alike Component Structure
(Drafting...)

### Using `state` to Update and Mutate the State of the Data
(Drafting...)

### Event Handling
(Drafting...)

### Using `refs` to Reference Child Component from Parent
(Drafting...)

### Wunderschön Shopping Cart Design

Using [`React.js`](https://facebook.github.io/react/) to construct the shopping cart component UI interface. Its structure is presented below:

```
- shopping-cart (Root Component)
  - message
  - icon
  - wrapper
    - header
    - body
      - caption
      - *item
        - quantity-field
    - footer

Hint: * means list-like components
```

(Drafting...)

## Axios - HTTP Client from Browsers & NodeJS

### Installation

(Drafting...)
### Basic Usage

(Drafting...)
## RxJS - Reactive Programming using Observable

### Installation

(Drafting...)
### Basic Usage 
(Drafting...)