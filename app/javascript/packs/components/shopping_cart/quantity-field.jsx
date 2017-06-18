import React from 'react'
import PropTypes from 'prop-types'

class ShoppingCartQuantityField extends React.Component {
  constructor(props) {
    super(props)
    this.handleAddUnitQuantityClick = this.handleAddUnitQuantityClick.bind(this)
    this.handleDeductUnitQuantityClick = this.handleDeductUnitQuantityClick.bind(this)
  }

  static defaultProps = {
    productId: NaN,
    quantity: 0
  }

  handleAddUnitQuantityClick(event) {
    event.preventDefault()
    $(event.target).addClass('disabled')
    this.props.addQuantity(this.props.productId)
  }

  handleDeductUnitQuantityClick(event) {
    event.preventDefault()
    if (this.props.quantity !== 1) $(event.target).addClass('disabled')
    this.props.deductQuantity(this.props.productId)
  }

  render() {
    return(
      <span className="shopping-cart-quantity-field">
        <span
          className="fa fa-plus add-quantity-btn"
          data-id={this.props.productId}
          onClick={this.handleAddUnitQuantityClick}
        ></span> {this.props.quantity} <span
          className="fa fa-minus deduct-quantity-btn"
          data-id={this.props.productId}
          onClick={this.handleDeductUnitQuantityClick}
        ></span>
      </span>
    )
  }
}

ShoppingCartQuantityField.propTypes = {
  productId: PropTypes.number.isRequired,
  quantity: PropTypes.number.isRequired
}

export default ShoppingCartQuantityField