/*
 *= require rxjs/bundles/Rx.min.js
 */
$(document).on('turbolinks:load', function() {
  $(this).scrollTop(0);
  var $productList = $('#product-list');
  var $billboard = $('#billboard');
  var threshold = $productList.offset().top;
  var scroll = Rx.Observable.fromEvent(document, 'scroll');
  var offsetHeight = 20;
  scroll
    .map(function(event) {
      event.scrollTop = calculateScrollTop(threshold, offsetHeight);
      return event;
    })
    .filter(function(event) {
      if (event.scrollTop > 0) return true;
      $productList.css('margin-top', 0);
      $navbar('desktop').css('opacity', 0.7 + 0.3 * -event.scrollTop / threshold);
      return false;
    })
    .subscribe(function(event) {
      $productList.css('margin-top', event.scrollTop);
    });
  
  var resize = Rx.Observable.fromEvent(window, 'resize');
  resize.subscribe(function() {
    $productList = $('#product-list');
    $billboard = $('#billboard');
    threshold = $productList.offset().top;
  })
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

function navbarHeight() {
  return $navbar().height();
}

function calculateScrollTop(threshold, offsetHeight) {
  return $(document).scrollTop() - threshold + navbarHeight() + offsetHeight;
}