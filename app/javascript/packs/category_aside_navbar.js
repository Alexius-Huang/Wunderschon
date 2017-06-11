let asideNavbarEvent = function() {
  $(this).scrollTop(0)
  let $productList = $('#product-list')
  let $billboard = $('#billboard')
  let threshold = $productList.offset().top
  let scroll = Rx.Observable.fromEvent(document, 'scroll')
  let offsetHeight = 20

  let getScrollTop = event => calculateScrollTop(threshold, offsetHeight) 
  let filterScrollTop = scrollTop => {
    if (scrollTop > 0) return true
    $productList.css('margin-top', 0)
    $navbar('desktop').css('opacity', 0.7 + 0.3 * -scrollTop / threshold)
    return false
  }
  let setNavbarPosition = scrollTop => $productList.css('margin-top', scrollTop) 
  scroll
    .map(getScrollTop)
    .filter(filterScrollTop)
    .subscribe(setNavbarPosition)
  
  let resize = Rx.Observable.fromEvent(window, 'resize')
  resetNavbarParams = () => {
    $productList = $('#product-list')
    $billboard = $('#billboard')
    threshold = $productList.offset().top
  }
  resize.subscribe(resetNavbarParams)
}

$(document).ready(asideNavbarEvent)
$(document).on('turbolinks:load', asideNavbarEvent)

function $navbar(version) {
  switch(version) {
    case 'mobile':
    case 'desktop':
      return $('#' + version + '-version-navbar')
    default:
      return $('#mobile-version-navbar').css('display') === 'none' ? $('#desktop-version-navbar') : $('#mobile-version-navbar')
  }
}

function navbarHeight() {
  return $navbar().height()
}

function calculateScrollTop(threshold, offsetHeight) {
  return $(document).scrollTop() - threshold + navbarHeight() + offsetHeight
}