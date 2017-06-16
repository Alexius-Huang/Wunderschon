import React from 'react'
import PropTypes from 'prop-types'
import ShoppingCartMessage from './message'

class ShoppingCartIcon extends React.Component {
  constructor(props) {
    super(props)
  }

  static defaultProps = {
    itemCount: 0
  };

  handleToggleShoppingCartWrapper() {
    const $shoppingCart = $('#shopping-cart > .shopping-cart > .shopping-cart-icon')
    const isDragging = $shoppingCart.hasClass('ui-dragging')
    if (isDragging) return
    const $wrapper = $('.shopping-cart-wrapper')
    if ($wrapper.css('display') == 'none') {
      $wrapper.css('display', 'block')
    } else {
      $wrapper.css('display', 'none')
    }
  }

  render() {
    return (
      <div className="shopping-cart-icon" onClick={this.handleToggleShoppingCartWrapper}>
        <span className="fa fa-shopping-cart"></span>
        <span className="item-count-tag">{this.props.itemCount}</span>
      </div>
    )
  }
}

ShoppingCartIcon.propTypes = {
  itemCount: PropTypes.number.isRequired
}

export default ShoppingCartIcon