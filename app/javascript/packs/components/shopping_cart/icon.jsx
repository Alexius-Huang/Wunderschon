import React from 'react'
import PropTypes from 'prop-types'

class ShoppingCartIcon extends React.Component {
  constructor(props) {
    super(props)
  }

  static defaultProps = {
    itemCount: 0
  };

  componentDidMount() {
    this.setupDragDropEvent()
  }

  setupDragDropEvent() {
    /* Drag and Drop Event for ShoppingCartIcon */
    const $icon = $('.shopping-cart-icon')
    const icon = $icon[0]
    const body = document.body

    const mouseDown = Rx.Observable.fromEvent(icon, 'mousedown')
    const mouseUp =   Rx.Observable.fromEvent(icon, 'mouseup')
    const mouseMove = Rx.Observable.fromEvent(body, 'mousemove')

    mouseDown
      .map(event => mouseMove.takeUntil(mouseUp))
      .concatAll()
      .map(event => ({ x: event.clientX, y: event.clientY }))
      .subscribe(pos => {
        /* Consult categories/shopping_cart.scss */
        $icon.addClass('ui-dragging')
        icon.style.left = pos.x - 40 + 'px'
        icon.style.top  = pos.y - 40 + 'px'
      })

    mouseUp.delay(500).subscribe(event => {
      if ($icon.hasClass('ui-dragging')) {
        $icon.removeClass('ui-dragging')
      }
    })
  }

  handleToggleShoppingCartWrapper() {
    const $icon = $('.shopping-cart-icon')
    const isDragging = $icon.hasClass('ui-dragging')
    if (isDragging) return
    const $wrapper = $('.shopping-cart-wrapper')
    if ($wrapper.css('display') == 'none') {
      $wrapper.fadeIn()
      $('.shopping-cart-bg').fadeIn();
    } else {
      $wrapper.fadeOut()
      $('.shopping-cart-bg').fadeOut();
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