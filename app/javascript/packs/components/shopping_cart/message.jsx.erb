import React from 'react'
import PropTypes from 'prop-types'

let $timeoutEvent = null
const $timeout = 5000

class ShoppingCartMessage extends React.Component {
  constructor(props) {
    super(props)
  }

  static defaultProps = {
    message: ''
  }

  trigger() {
    this.triggerMessageFadeEffect()
    this.setupCloseMessageEvent()
  }

  setupCloseMessageEvent($message = $('.shopping-cart-message')) {
    const source = Rx.Observable.fromEvent($message[0], 'click')
    source.subscribe(() => {
      if (this.messagePresent()) {
        $message.fadeOut()
        this.disableTimeout()
      }
    })
  }

  triggerMessageFadeEffect($message = $('.shopping-cart-message')) {
    if (this.messagePresent()) this.disableTimeout()
    $message.fadeIn()
    $timeoutEvent = setTimeout(() => $message.fadeOut(), $timeout)
  }

  disableTimeout() {
    window.clearTimeout($timeoutEvent)
    $timeoutEvent = null
  }

  messagePresent($message = $('.shopping-cart-message')) {
    return $message.css('display') != 'none'
  }

  render() {
    return (
      <div className="shopping-cart-message">
        <p>{this.props.message}</p>
      </div>
    )
  }
}

ShoppingCartMessage.propTypes = {
  message: PropTypes.string,
}

export default ShoppingCartMessage