import React from 'react'
import PropTypes from 'prop-types'

class OrderBillingShipping extends React.Component {
  constructor(props) {
    super(props)
  }

  render() {
    return (
      <div className="order-section">
        This is the billing and shipping section
      </div>
    )
  }
}

OrderBillingShipping.propTypes = {}

export default OrderBillingShipping