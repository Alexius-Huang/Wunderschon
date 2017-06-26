import React from 'react'
import ReactDOM from 'react-dom'
import ShoppingCartIcon from './shopping_cart/icon'
import ShoppingCartMessage from './shopping_cart/message'
import ShoppingCartWrapper from './shopping_cart/wrapper'

const Events = {
  'ADD_CART_ITEM': 'ADD_CART_ITEM',
  'ADD_QUANTITY': 'ADD_QUANTITY',
  'DEDUCT_QUANTITY': 'DEDUCT_QUANTITY'
}

class ShoppingCart extends React.Component {
  constructor(props) {
    super(props)
    this.state = { totalPrice: 0, empty: true, itemCount: 0, items: [], message: '' }
    this.setupAddCartItemEvent()
    this.handleAddQuantity = this.handleAddQuantity.bind(this)
    this.handleDeductQuantity = this.handleDeductQuantity.bind(this)
    this.handleCloseShoppingCart = this.handleCloseShoppingCart.bind(this)
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
        $(this).addClass('disabled')
        observer.next($(this))
      })
    }
    let getProductId = el => el.data('id')
    let addCartItem = (productId) => this.postAddProduct(productId)
    let resolved = (request) => {
      request.then((response) => {
        let { status, product } = response.data
        if (status === 200) this.updateShoppingCart('ADD_CART_ITEM', product)
        setTimeout(() => $(`.custom-container a.add-cart-item-btn[data-id="${product.id}"]`).removeClass('disabled'), 500)
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

  postAddProduct(productId, quantity = 1, url = '/ajax/cart/add_product.json') {
    return Axios.post(url, { product_id: productId, quantity: quantity })
  }

  postDeductProduct(productId, quantity = 1, url = '/ajax/cart/delete_product.json') {
    return Axios.post(url, { product_id: productId, quantity: quantity })
  }

  handleAddQuantity(productId, quantity = 1) {
    if (productId) {
      this.postAddProduct(productId, quantity).then(response => {
        let { status, product } = response.data
        if (status === 200) this.updateShoppingCart('ADD_QUANTITY')
        window.setTimeout(() => $(`.add-quantity-btn[data-id="${productId}"]`).removeClass('disabled'), 500)
      })
    }
  }

  handleDeductQuantity(productId, quantity = 1) {
    if (productId) {
      this.postDeductProduct(productId, quantity).then(response => {
        let { status, product } = response.data
        if (status === 200) this.updateShoppingCart('DEDUCT_QUANTITY')
        if ($(`.deduct-quantity-btn[data-id="${productId}"].disabled`)[0]) window.setTimeout(() => $(`.deduct-quantity-btn[data-id="${productId}"].disabled`).removeClass('disabled'), 500)
      })
    }
  }

  handleCloseShoppingCart(event) {
    this.refs.wrapper.handleCloseShoppingCart(event)
  }

  updateShoppingCart(event, ...params) {
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
            message: this.refs.message.productAddedMessage(product)
          })
          this.refs.message.trigger()
          break;

        /* Default Update Behaviours */
        case 'ADD_QUANTITY':
        case 'DEDUCT_QUANTITY':
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
    const t = JSON.parse(this.props.translations)
    return (
      <div className="shopping-cart">
        <div className="shopping-cart-bg" onClick={this.handleCloseShoppingCart}></div>
        <ShoppingCartMessage
          message={this.state.message}
          ref="message"
          translations={t}
        />
        <ShoppingCartIcon
          itemCount={this.state.itemCount}
          translations={t}
        />
        <ShoppingCartWrapper
          totalPrice={this.state.totalPrice}
          empty={this.state.empty}
          itemCount={this.state.itemCount}
          items={this.state.items}
          addQuantity={this.handleAddQuantity}
          deductQuantity={this.handleDeductQuantity}
          translations={t}
          ref="wrapper"
        />
      </div>
    )
  }
}

export default ShoppingCart