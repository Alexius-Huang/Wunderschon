import React from 'react'
import PropTypes from 'prop-types'
import ShoppingCartItem from './item'
import ShoppingCartCaption from './caption'

class ShoppingCartBody extends React.Component {
  constructor(props) {
    super(props)
    this.addQuantity = this.addQuantity.bind(this)
    this.deductQuantity = this.deductQuantity.bind(this)
  }

  static defaultProps = {
    items: [],
    empty: true
  };

  addQuantity(productId, quantity = 1) {
    if (productId) { this.props.addQuantity(productId, quantity) }
  }

  deductQuantity(productId, quantity = 1) {
    if (productId) { this.props.deductQuantity(productId, quantity) }
  }

  render() {
    const renderCartItems = this.props.items.map((item, index) => 
      <ShoppingCartItem
        key={index}
        product={item.product}
        quantity={item.quantity}
        price={item.price}
        totalPrice={item.total_price}
        addQuantity={this.addQuantity}
        deductQuantity={this.deductQuantity}
      />
    )
    return (
      <div className="shopping-cart-body">
        <ShoppingCartCaption />
        {renderCartItems}
      </div>
    )
  }
}

ShoppingCartBody.propTypes = {
  items: PropTypes.array.isRequired,
  empty: PropTypes.bool.isRequired
}

export default ShoppingCartBody