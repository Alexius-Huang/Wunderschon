import React from 'react'
import PropTypes from 'prop-types'
import OrderBody from './body'
import OrderFooter from './footer'

class OrderWrapper extends React.Component {
  constructor(props) {
    super(props)
    this.previousStep = this.previousStep.bind(this)
    this.nextStep = this.nextStep.bind(this)
    this.fieldChange = this.fieldChange.bind(this)
  }

  static defaultProps = {
    totalProgress: NaN,
    currentProgress: 1
  };

  previousStep(bool) {
    this.props.previousStep(bool)
  }

  nextStep(bool) {
    this.props.nextStep(bool)
  }

  fieldChange(fieldName, fieldValue) {
    this.props.fieldChange(fieldName, fieldValue)
  }

  render() {
    const t = this.props.translations
    return (
      <div className="order-wrapper">
        <OrderBody
          ref="body"
          fieldChange={this.fieldChange}
          nameField={this.props.nameField}
          emailField={this.props.emailField}
          addressField={this.props.addressField}
          telField={this.props.telField}
          currentProgress={this.props.currentProgress}
          translations={t}
        />
        <OrderFooter
          totalProgress={this.props.totalProgress}
          currentProgress={this.props.currentProgress}
          previousStep={this.previousStep}
          nextStep={this.nextStep}
          translations={t}
        />
      </div>
    )
  }
}

OrderWrapper.propTypes = {
  currentProgress: PropTypes.number.isRequired,
  totalProgress: PropTypes.number.isRequired,
  previousStep: PropTypes.func.isRequired,
  nextStep: PropTypes.func.isRequired,
  fieldChange: PropTypes.func.isRequired
}

export default OrderWrapper