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
    // const $footer = $('.shopping-cart-footer')
    // const $button = $(event.target)
    // const animatePosition = $footer.outerWidth() - $button.outerWidth()
    // $button.animate({ right: animatePosition })
    this.props.checkoutCartOrder(true)
  }

  render() {
    return (
      <div className="shopping-cart-footer">
        <button
          className="bg-danger"
          id="checkout-btn"
          onClick={this.handleCheckOutButtonClick}
        >Checkout ${this.props.totalPrice}</button>
      </div>
    )
  }
}

ShoppingCartFooter.propTypes = {
  totalPrice: PropTypes.number.isRequired,
  checkoutCartOrder: PropTypes.func.isRequired
}

export default ShoppingCartFooter