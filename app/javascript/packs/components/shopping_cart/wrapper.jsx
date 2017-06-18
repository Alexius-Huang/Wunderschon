import React from 'react'
import PropTypes from 'prop-types'
import ShoppingCartHeader from './header'
import ShoppingCartBody from './body'
import ShoppingCartFooter from './footer'

class ShoppingCartWrapper extends React.Component {
  constructor(props) {
    super(props)
    this.checkoutCartOrder = this.checkoutCartOrder.bind(this)
    this.addQuantity = this.addQuantity.bind(this)
    this.deductQuantity = this.deductQuantity.bind(this)
  }

  static defaultProps = {
    totalPrice: 0,
    empty: true,
    itemCount: 0,
    items: []
  };

  checkoutCartOrder(bool) {
    if (bool) { this.props.checkoutCartOrder(true) }
  }

  handleCloseShoppingCart(event) {
    event.preventDefault()
    const $wrapper = $('.shopping-cart-wrapper')
    $wrapper.fadeOut()
  }

  addQuantity(productId, quantity = 1) {
    if (productId) { this.props.addQuantity(productId, quantity) }
  }

  deductQuantity(productId, quantity = 1) {
    if (productId) { this.props.deductQuantity(productId, quantity) }
  }

  render() {
    return (
      <div className='shopping-cart-wrapper'>
        <span
          className="close-shopping-cart-btn fa fa-times"
          onClick={this.handleCloseShoppingCart}
        ></span>
        <ShoppingCartHeader
          totalPrice={this.props.totalPrice}
          itemCount={this.props.itemCount}
        />
        <ShoppingCartBody
          empty={this.props.empty}
          items={this.props.items}
          addQuantity={this.addQuantity}
          deductQuantity={this.deductQuantity}
        />
        <ShoppingCartFooter
          totalPrice={this.props.totalPrice}
          checkoutCartOrder={this.checkoutCartOrder}
        />
      </div>
    )
  }
}

ShoppingCartWrapper.propTypes = {
  totalPrice: PropTypes.number.isRequired,
  empty: PropTypes.bool.isRequired,
  itemCount: PropTypes.number.isRequired,
  items: PropTypes.array.isRequired,
  checkoutCartOrder: PropTypes.func.isRequired
}

export default ShoppingCartWrapper