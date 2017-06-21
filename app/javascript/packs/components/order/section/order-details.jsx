import React from 'react'
import PropTypes from 'prop-types'

class OrderOrderDetails extends React.Component {
  constructor(props) {
    super(props)
    this.handleNameFieldChange = this.handleNameFieldChange.bind(this)
    this.handleEmailFieldChange = this.handleEmailFieldChange.bind(this)
    this.handleAddressFieldChange = this.handleAddressFieldChange.bind(this)
    this.handleTelFieldChange = this.handleTelFieldChange.bind(this)
  }

  handleNameFieldChange(event) {
    this.props.fieldChange('name', event.target.value)
  }

  handleEmailFieldChange(event) {
    this.props.fieldChange('email', event.target.value)
  }

  handleAddressFieldChange(event) {
    this.props.fieldChange('address', event.target.value)
  }

  handleTelFieldChange(event) {
    this.props.fieldChange('tel', event.target.value)
  }

  render() {
    return (
      <div className="order-section">
        <div className="row">
          <div className="col-md-6 col-sm-6 col-xs-12">
            <label htmlFor="order_name">姓名</label> <br/>
            <input id="order_name" type="text" name="name" value={this.props.nameField} onChange={this.handleNameFieldChange} />
          </div>
          <div className="col-md-6 col-sm-6 col-xs-12">
            <label htmlFor="order_email">電郵</label> <br/>
            <input id="order_email" type="text" name="email" value={this.props.emailField} onChange={this.handleEmailFieldChange} />  
          </div>
          <div className="col-md-6 col-sm-6 col-xs-12">
            <label htmlFor="order_address">地址</label> <br/>
            <input id="order_address" type="text" name="address" value={this.props.addressField} onChange={this.handleAddressFieldChange} />
          </div>
          <div className="col-md-6 col-sm-6 col-xs-12">
            <label htmlFor="order_tel">聯絡電話</label> <br/>
            <input id="order_tel" type="text" name="tel" value={this.props.telField} onChange={this.handleTelFieldChange} />
          </div>
        </div>
      </div>
    )
  }
}

OrderOrderDetails.propTypes = {
  fieldChange: PropTypes.func.isRequired
}

export default OrderOrderDetails