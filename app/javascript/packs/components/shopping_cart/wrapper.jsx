import React from 'react'
import PropTypes from 'prop-types'

class ShoppingCartWrapper extends React.Component {
  constructor(props) {
    super(props)
  }

  static defaultProps = {
    totalPrice: 0,
    empty: true,
    itemCount: 0,
    items: []
  };

  render() {
    return (
      <div className='shopping-cart-wrapper'>
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