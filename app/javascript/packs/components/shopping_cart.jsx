import React from 'react'
import ReactDOM from 'react-dom'
import ShoppingCartIcon from './shopping_cart/icon'
import ShoppingCartMessage from './shopping_cart/message'
import ShoppingCartWrapper from './shopping_cart/wrapper'

const Events = {
  'ADD_CART_ITEM': 'ADD_CART_ITEM',
  'CHECKOUT': 'CHECKOUT'
}

class ShoppingCart extends React.Component {
  constructor(props) {
    super(props)
    this.state = { totalPrice: 0, empty: true, itemCount: 0, items: [], message: '' }
    this.setupAddCartItemEvent()
    this.handleCheckoutCartOrder = this.handleCheckoutCartOrder.bind(this)
  }

  componentWillMount() {
    this.getCartInfo().then(response => {
      const { total_price: totalPrice, empty: empty, items: items, item_count: itemCount } = response.data;
      this.setState({ totalPrice: totalPrice, empty: empty, itemCount: itemCount, items: items })
    })
  }

  setupAddCartItemEvent(url = '/ajax/cart/add_product.json') {
    let buttonEventEmitter = (observer) => {
      $('.custom-container').on('click', 'a.add-cart-item-btn', function(event) {
        event.preventDefault()
        observer.next($(this))
      })
    }
    let getProductId = el => el.data('id')
    let addCartItem = (productId) => Axios.post(url, { product_id: productId })
    let resolved = (request) => {
      request.then((response) => {
        let { status, product } = response.data
        if (status === 200) this.updateCart('ADD_CART_ITEM', product)
      })
    }

    let source = Rx.Observable.create(buttonEventEmitter)
    source
      .map(getProductId)
      .map(addCartItem)
      .subscribe(resolved)
  }

  getCartInfo(url = '/ajax/cart/info.json') {
    return Axios.get(url)
  }

  productAddedMessage(product) {
    return `${product.title} has been added to cart!`
  }

  handleCheckoutCartOrder(bool) {
    if (bool) { this.updateCart('CHECKOUT') }
  }

  updateCart(event, ...params) {
    this.getCartInfo().then(response => {
      const { total_price: totalPrice, empty: empty, items: items, item_count: itemCount } = response.data;
      switch(Events[event]) {
        case 'ADD_CART_ITEM':
          const product = params[0]
          this.setState({
            totalPrice: totalPrice,
            empty: empty,
            itemCount: itemCount,
            items: items,
            message: this.productAddedMessage(product)
          })
          break;
        case 'CHECKOUT':
          break;
        default:
          this.setState({
            totalPrice: totalPrice,
            empty: empty,
            itemCount: itemCount,
            items: items,
          })
      }
    })
  }

  render() {
    return (
      <div className="shopping-cart">
        <ShoppingCartMessage
          message={this.state.message}
        />
        <ShoppingCartIcon
          itemCount={this.state.itemCount}
        />
        <ShoppingCartWrapper
          totalPrice={this.state.totalPrice}
          empty={this.state.empty}
          itemCount={this.state.itemCount}
          items={this.state.items}
          checkoutCartOrder={this.handleCheckoutCartOrder}
        />
      </div>
    )
  }
}

export default ShoppingCart