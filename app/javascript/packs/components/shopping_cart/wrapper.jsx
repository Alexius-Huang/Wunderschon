import React from 'react'
import PropTypes from 'prop-types'
import ShoppingCartHeader from './header'
import ShoppingCartBody from './body'
import ShoppingCartFooter from './footer'

class ShoppingCartWrapper extends React.Component {
  constructor(props) {
    super(props)
    this.checkoutCartOrder = this.checkoutCartOrder.bind(this)
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

  render() {
    return (
      <div className='shopping-cart-wrapper'>
        <ShoppingCartHeader
          totalPrice={this.props.totalPrice}
          itemCount={this.props.itemCount}
        />
        <ShoppingCartBody
          empty={this.props.empty}
          items={this.props.items}
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