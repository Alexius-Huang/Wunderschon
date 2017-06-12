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

window.jQuery = jQuery

$(document).ready(() => {
	let navbarItemCount = $('#mobile-slide-menu').children().length;
  let navbarItemHeight = 51;
  let navbarHeight = $navbar('mobile').height();
  let offset = 10;
  let unit = 'px';
  $('#categories-icon').click((event) => {
		$(this).toggleClass('open');
    if ($('#mobile-version-navbar').css('display') !== 'none' && $(this).hasClass('open')) {
      let height = navbarItemCount * navbarItemHeight + navbarHeight + offset + unit;
      $('#mobile-version-navbar').animate({
        height: height
      }, () => {
        for (var el of $('#mobile-slide-menu').children()) $(el).fadeIn();
      });
    } else {
      $('#mobile-version-navbar').animate({ height: navbarHeight + unit });
      for (var el of $('#mobile-slide-menu').children()) $(el).fadeOut();
    }
	});
});

function $navbar(version) {
  switch(version) {
    case 'mobile':
    case 'desktop':
      return $('#' + version + '-version-navbar');
    default:
      return $('#mobile-version-navbar').css('display') === 'none' ? $('#desktop-version-navbar') : $('#mobile-version-navbar');
  }
}
