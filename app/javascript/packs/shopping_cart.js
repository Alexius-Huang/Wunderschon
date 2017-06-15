import React from 'react'
import ReactDOM from 'react-dom'
import ShoppingCart from './components/shopping_cart'

const shoppingCartEvent = function() {
  /* Drag and Drop Event for ShoppingCartIcon */
  const shoppingCart = $('#shopping-cart > .shopping-cart > .shopping-cart-icon')[0]
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
      shoppingCart.style.left = pos.x - 40 + 'px'
      shoppingCart.style.top  = pos.y - 40 + 'px'
    })
}

$(document).on('turbolinks:load', shoppingCartEvent)

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <ShoppingCart name="React" />,
    $('div#shopping-cart')[0]
  )
})