let shoppingCartEvent = function() {
  let buttonEventEmitter = (observer) => {
    $('.custom-container').on('click', 'a.add-cart-item-btn', function(event) {
      event.preventDefault()
      observer.next($(this))
    })
  }
  let getProductId = el => el.data('id')
  let addCartItem = (productId) => Axios.post('/ajax/cart/add_product.json', { product_id: productId })
  let resolved = (request) => {
    request.then((response) => {
      /* Response Here */
      console.log(response.data)
    });
  }

  let source = Rx.Observable.create(buttonEventEmitter)
  source
    .map(getProductId)
    .map(addCartItem)
    .subscribe(resolved)
}

$(document).on('turbolinks:load', shoppingCartEvent)