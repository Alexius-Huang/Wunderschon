/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import jQuery from 'jquery'
import Rx from 'Rx'
import PIXI from 'PIXI'
import Axios from 'axios'

window.jQuery = jQuery

// Support component names relative to this directory:
var componentRequireContext = require.context('packs/components', true)
var ReactRailsUJS = require('react_ujs')
ReactRailsUJS.useContext(componentRequireContext)

$(document).ready(() => {
	let animating = false
  $('#categories-icon').click(function(event) {
    if (animating) return
    animating = true
		$(this).toggleClass('open')
    if ($(this).hasClass('open')) {
      castShadow(true)
      $('#mobile-version-navbar').animate({ height: '260pt' }, function() {
        $('#mobile-slide-menu').fadeIn(function() {
          animating = false
        })
      })
    } else {
      $('#mobile-slide-menu').fadeOut(500, function() {
        $('#mobile-version-navbar').animate({ height: '50pt' }, function() {
          castShadow(false)
          animating = false
        })
      })
    }
	})

  /* Mounting All the React Components Globally */
  ReactRailsUJS.mountComponents()
})

function castShadow(bool, shadow = '0 5pt 5pt rgba(0, 0, 0, 0.3)') {
  if (bool) {
    $('#mobile-navbar-caption').css('box-shadow', shadow)
  } else {
    $('#mobile-navbar-caption').css('box-shadow', 'none')
  }
}
