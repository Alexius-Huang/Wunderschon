import React from 'react'
import PropTypes from 'prop-types'

class OrderProgressIcon extends React.Component {
  constructor(props) {
    super(props)
  }

  static defaultProps = {
    number: NaN,
    active: false
  }

  componentClassName() {
    return `order-progress-icon ${this.props.active ? 'active' : ''}`
  }

  render() {
    return (
      <div className={this.componentClassName()} >
        <span>{this.props.number}</span>
      </div>
    )
  }
}

OrderProgressIcon.propTypes = {
  number: PropTypes.number.isRequired,
  active: PropTypes.bool.isRequired
}

export default OrderProgressIcon