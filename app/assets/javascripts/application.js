// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require jquery_ujs
//= require rails-ujs
//= require turbolinks

$(document).ready(function(){
	var navbarItemCount = $('#mobile-slide-menu').children().length;
  var navbarItemHeight = 51;
  var navbarHeight = $navbar('mobile').height();
  var offset = 10;
  var unit = 'px';
  $('#categories-icon').click(function(){
		$(this).toggleClass('open');
    if ($('#mobile-version-navbar').css('display') !== 'none' && $(this).hasClass('open')) {
      var height = navbarItemCount * navbarItemHeight + navbarHeight + offset + unit;
      $('#mobile-version-navbar').animate({
        height: height
      }, function() {
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
