import React from 'react'
import PropTypes from 'prop-types'
import OrderLightBox from './order/light-box'
import OrderProgressIndicator from './order/progress-indicator'
import OrderWrapper from './order/wrapper'
import OrderForm from './order/form'

const $events = {
  'PREVIOUS_STEP': 'PREVIOUS_STEP',
  'NEXT_STEP': 'NEXT_STEP',
  'FIELD_CHANGE': 'FIELD_CHANGE'
}
const $orderFields = ['name', 'email', 'address', 'tel']

class Order extends React.Component {
  constructor(props) {
    super(props)
    const t = JSON.parse(this.props.translations)
    const $progresses = [
      { number: 1, title: t.section.review_items.title     },
      { number: 2, title: t.section.order_details.title    },
      { number: 3, title: t.section.billing_shipping.title },
      { number: 4, title: t.section.confirm.title          }
    ]
    this.state = {
      currentProgress: 1,
      totalProgress: $progresses.length,
      progresses: $progresses,
      nameField: '',
      emailField: '',
      addressField: '',
      telField: ''
    }
    this.handlePreviousStep = this.handlePreviousStep.bind(this)
    this.handleNextStep = this.handleNextStep.bind(this)
    this.handleFieldChange = this.handleFieldChange.bind(this)
  }

  static defaultProps = {
    orderFields: $orderFields
  };

  handlePreviousStep(bool) {
    if (bool) {
      const orderBody = this.refs.wrapper.refs.body
      orderBody.slidePrevious()
      this.updateOrder('PREVIOUS_STEP')
    }
  }

  handleNextStep(bool) {
    if (bool) {
      const orderBody = this.refs.wrapper.refs.body
      orderBody.slideNext()
      this.updateOrder('NEXT_STEP')
    }
  }

  handleFieldChange(fieldName, fieldValue) {
    this.updateOrder('FIELD_CHANGE', fieldName, fieldValue)
  }

  updateOrder(event, ...params) {
    switch($events[event]) {
      case 'PREVIOUS_STEP':
        this.setState({ currentProgress: this.state.currentProgress - 1 })
        break;
      case 'NEXT_STEP':
        this.setState({ currentProgress: this.state.currentProgress + 1 })
        break;
      case 'FIELD_CHANGE':
        this.setState({ [`${params[0]}Field`]: params[1] })
      default:
    }
  }

  render() {
    const t = JSON.parse(this.props.translations)
    debugger
    return (
      <div className="order">
        <OrderLightBox translations={t} />
        <OrderProgressIndicator
          progresses={this.state.progresses}
          currentProgress={this.state.currentProgress}
          translation={t}
        />
        <OrderWrapper
          ref="wrapper"
          currentProgress={this.state.currentProgress}
          nameField={this.state.nameField}
          emailField={this.state.emailField}
          addressField={this.state.addressField}
          telField={this.state.telField}
          totalProgress={this.state.totalProgress}
          previousStep={this.handlePreviousStep}
          nextStep={this.handleNextStep}
          fieldChange={this.handleFieldChange}
          translation={t}
        />
        <OrderForm
          ref="order_form"
          nameField={this.state.nameField}
          emailField={this.state.emailField}
          addressField={this.state.addressField}
          telField={this.state.telField}
          orderFields={this.props.orderFields}
          authenticityToken={this.props.authenticity_token}
          translation={t}
        />
      </div>
    );
  }
}

Order.propTypes = {
  authenticity_token: PropTypes.string.isRequired
}

export default Order