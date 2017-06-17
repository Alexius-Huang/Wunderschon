import React from 'react'
import PropTypes from 'prop-types'
import ShoppingCartItem from './item'
import ShoppingCartCaption from './caption'

class ShoppingCartBody extends React.Component {
  constructor(props) {
    super(props)
  }

  static defaultProps = {
    items: [],
    empty: true
  };

  render() {
    const renderCartItems = this.props.items.map((item, index) => 
      <ShoppingCartItem
        key={index}
        product={item.product}
        quantity={item.quantity}
        price={item.price}
        totalPrice={item.total_price}
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