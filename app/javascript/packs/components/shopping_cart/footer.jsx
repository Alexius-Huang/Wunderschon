import React from 'react'
import PropTypes from 'prop-types'

class ShoppingCartFooter extends React.Component {
  constructor(props) {
    super(props)
  }

  static defaultProps = {
    totalPrice: 0
  }

  render() {
    return (
      <div className="shopping-cart-footer">
        <a
          id="checkout-btn"
          href="/orders/checkout"
        >{this.props.translations.footer.checkout} ${this.props.totalPrice}</a>
      </div>
    )
  }
}

ShoppingCartFooter.propTypes = {
  totalPrice: PropTypes.number.isRequired
}

export default ShoppingCartFooter