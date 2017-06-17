import React from 'react'
import PropTypes from 'prop-types'

class ShoppingCartHeader extends React.Component {
  constructor(props) {
    super(props)
  }

  static defaultProps = {
    totalPrice: 0,
    empty: true
  };

  render() {
    return (
      <div className="shopping-cart-header">
        <div className="row">
          <div className="col-xl-6 col-lg-6 col-md-6 col-sm-6">
            Shopping Cart
          </div>
          <div className="col-xl-6 col-lg-6 col-md-6 col-sm-6 text-right">
            Total Price: ${this.props.totalPrice}
          </div>
        </div>
      </div>
    )
  }
}

ShoppingCartHeader.propTypes = {
  totalPrice: PropTypes.number.isRequired,
  empty: PropTypes.bool.isRequired
}

export default ShoppingCartHeader