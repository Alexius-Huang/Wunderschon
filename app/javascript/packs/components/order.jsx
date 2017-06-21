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
const $progresses = [
  { number: 1, title: '檢視購物車商品' },
  { number: 2, title: '填寫基本資料' },
  { number: 3, title: '送貨方式與付費' },
  { number: 4, title: '確認訂單' }
]
const $orderFields = ['name', 'email', 'address', 'tel']

class Order extends React.Component {
  constructor(props) {
    super(props)
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
    totalProgress: $progresses.length,
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
    return (
      <div className="order">
        <OrderLightBox />
        <OrderProgressIndicator
          progresses={this.state.progresses}
          currentProgress={this.state.currentProgress}
        />
        <OrderWrapper
          ref="wrapper"
          currentProgress={this.state.currentProgress}
          nameField={this.state.nameField}
          emailField={this.state.emailField}
          addressField={this.state.addressField}
          telField={this.state.telField}
          totalProgress={this.props.totalProgress}
          previousStep={this.handlePreviousStep}
          nextStep={this.handleNextStep}
          fieldChange={this.handleFieldChange}
        />
        <OrderForm
          ref="order_form"
          nameField={this.state.nameField}
          emailField={this.state.emailField}
          addressField={this.state.addressField}
          telField={this.state.telField}
          orderFields={this.props.orderFields}
          authenticityToken={this.props.authenticity_token}
        />
      </div>
    );
  }
}

Order.propTypes = {
  totalProgress: PropTypes.number.isRequired,
  authenticity_token: PropTypes.string.isRequired
}

export default Order