import React from 'react'
import PropTypes from 'prop-types'

class ShoppingCartItem extends React.Component {
  constructor(props) {
    super(props)
  }

  static defaultProps = {
    product: {},
    quantity: 0,
    price: 0,
    totalPrice: 0
  }

  render() {
    return (
      <div className="shopping-cart-item">
        <div className="row">
          <div className="item-img col-xl-2 col-lg-2 col-md-2 col-sm-2">
            <img src="http://fakeimg.pl/300" />
          </div>
          <div className="item-info col-xl-4 col-lg-4 col-md-4 col-sm-4">
            <span>{this.props.product.title}</span>
          </div>
          <div className="item-info text-center col-xl-2 col-lg-2 col-md-2 col-sm-2">
            <span>{this.props.product.price}</span>
          </div>
          <div className="item-info text-center col-xl-2 col-lg-2 col-md-2 col-sm-2">
            <span>{this.props.quantity}</span>
          </div>
          <div className="item-info text-center col-xl-2 col-lg-2 col-md-2 col-sm-2">
            <span>{this.props.totalPrice}</span>
          </div>
        </div>
      </div>
    )
  }
}

ShoppingCartItem.propTypes = {
  product: PropTypes.object.isRequired,
  quantity: PropTypes.number.isRequired,
  price: PropTypes.number.isRequired,
  totalPrice: PropTypes.number.isRequired
}

export default ShoppingCartItem