import React from 'react'
import PropTypes from 'prop-types'

class ShoppingCartIcon extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <div className="shopping-cart-icon">
        <span className="fa fa-shopping-cart"></span>
        <span className="item-count-tag">{this.props.itemCount}</span>
      </div>
    )
  }
}

export default ShoppingCartIcon