import React from 'react'
import PropTypes from 'prop-types'

class OrderForm extends React.Component {
  constructor(props) {
    super(props)
  }

  static defaultProps = {
    authenticityToken: null,
    url: '/order/create',
    method: 'post',
    acceptCharset: 'UTF-8'
  };

  render() {
    const renderFormFields = this.props.orderFields.map((field, index) =>
      <input key={index} type="hidden" name={`order[${field}]`} value={this.props[`${field}Field`]} />
    )
    return (
      <form
        ref="form"
        id="order-checkout-form"
        action={this.props.url}
        method={this.props.method}
        acceptCharset={this.props.acceptCharset}
      >
        <input type="hidden" name="authenticity_token" value={this.props.authenticityToken} />
        {renderFormFields}
      </form>
    )
  }
}

OrderForm.propTypes = {
  authenticityToken: PropTypes.string.isRequired,
  orderFields: PropTypes.array.isRequired,
  nameField: PropTypes.string
}

export default OrderForm