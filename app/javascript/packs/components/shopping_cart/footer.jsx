import React from 'react'
import PropTypes from 'prop-types'

class ShoppingCartFooter extends React.Component {
  constructor(props) {
    super(props)
    this.handleCheckOutButtonClick = this.handleCheckOutButtonClick.bind(this)
  }

  static defaultProps = {
    totalPrice: 0
  }

  handleCheckOutButtonClick(event) {
    event.preventDefault()
    this.props.checkoutCartOrder(true)
  }

  render() {
    return (
      <div className="shopping-cart-footer">
        <button
          className="pull-right bg-danger"
          id="checkout-btn"
          onClick={this.handleCheckOutButtonClick}
        >Checkout (${this.props.totalPrice})</button>
      </div>
    )
  }
}

ShoppingCartFooter.propTypes = {
  totalPrice: PropTypes.number.isRequired,
  checkoutCartOrder: PropTypes.func.isRequired
}

export default ShoppingCartFooter