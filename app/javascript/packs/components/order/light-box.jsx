import React from 'react'
import PropTypes from 'prop-types'

class OrderLightBox extends React.Component {
  constructor(props) {
    super(props)
  }

  render() {
    return (
      <div className="order-light-box">
        <div className="order-light-box-wrapper">
          This is the order-light-box component
        </div>
      </div>
    )
  }
}

OrderLightBox.propTypes = {}

export default OrderLightBox