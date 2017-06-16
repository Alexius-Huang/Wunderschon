import React from 'react'
import ReactDOM from 'react-dom'
import ShoppingCart from './components/shopping_cart'

const shoppingCartEvent = function() {
  /* Drag and Drop Event for ShoppingCartIcon */
  const $shoppingCart = $('#shopping-cart > .shopping-cart > .shopping-cart-icon')
  const shoppingCart = $shoppingCart[0]
  const body = document.body

  const mouseDown = Rx.Observable.fromEvent(shoppingCart, 'mousedown')
  const mouseUp =   Rx.Observable.fromEvent(body, 'mouseup')
  const mouseMove = Rx.Observable.fromEvent(body, 'mousemove')

  mouseDown
    .map(event => mouseMove.takeUntil(mouseUp))
    .concatAll()
    .map(event => ({ x: event.clientX, y: event.clientY }))
    .subscribe(pos => {
      /* Consult categories/shopping_cart.scss */
      $shoppingCart.addClass('ui-dragging')
      shoppingCart.style.left = pos.x - 40 + 'px'
      shoppingCart.style.top  = pos.y - 40 + 'px'
    })

  mouseUp.delay(500).subscribe(event => {
    if ($shoppingCart.hasClass('ui-dragging')) {
      $shoppingCart.removeClass('ui-dragging')
    }
  })
}

$(document).on('turbolinks:load', shoppingCartEvent)

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <ShoppingCart name="React" />,
    $('div#shopping-cart')[0]
  )
})