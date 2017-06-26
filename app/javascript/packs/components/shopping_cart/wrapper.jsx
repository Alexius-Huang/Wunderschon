import React from 'react'
import PropTypes from 'prop-types'
import ShoppingCartHeader from './header'
import ShoppingCartBody from './body'
import ShoppingCartFooter from './footer'

class ShoppingCartWrapper extends React.Component {
  constructor(props) {
    super(props)
    this.addQuantity = this.addQuantity.bind(this)
    this.deductQuantity = this.deductQuantity.bind(this)
    this.handleCloseShoppingCart = this.handleCloseShoppingCart.bind(this)
  }

  static defaultProps = {
    totalPrice: 0,
    empty: true,
    itemCount: 0,
    items: []
  };

  handleCloseShoppingCart(event) {
    event.preventDefault()
    const $wrapper = $('.shopping-cart-wrapper')
    $wrapper.fadeOut()
    $('.shopping-cart-bg').fadeOut()
  }

  addQuantity(productId, quantity = 1) {
    if (productId) { this.props.addQuantity(productId, quantity) }
  }

  deductQuantity(productId, quantity = 1) {
    if (productId) { this.props.deductQuantity(productId, quantity) }
  }

  render() {
    const t = this.props.translations
    return (
      <div className='shopping-cart-wrapper'>
        <span
          className="close-shopping-cart-btn fa fa-times"
          onClick={this.handleCloseShoppingCart}
        ></span>
        <ShoppingCartHeader
          totalPrice={this.props.totalPrice}
          itemCount={this.props.itemCount}
          translations={t}
        />
        <ShoppingCartBody
          empty={this.props.empty}
          items={this.props.items}
          addQuantity={this.addQuantity}
          deductQuantity={this.deductQuantity}
          translations={t}
        />
        <ShoppingCartFooter
          totalPrice={this.props.totalPrice}
          translations={t}
        />
      </div>
    )
  }
}

ShoppingCartWrapper.propTypes = {
  totalPrice: PropTypes.number.isRequired,
  empty: PropTypes.bool.isRequired,
  itemCount: PropTypes.number.isRequired,
  items: PropTypes.array.isRequired
}

export default ShoppingCartWrapper