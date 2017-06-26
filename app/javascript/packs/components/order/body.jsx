import React from 'react'
import PropTypes from 'prop-types'
import OrderReviewItems from './section/review-items'
import OrderOrderDetails from './section/order-details'
import OrderBillingShipping from './section/billing-shipping'
import OrderConfirm from './section/confirm'

class OrderBody extends React.Component {
  constructor(props) {
    super(props)
    this.fieldChange = this.fieldChange.bind(this)
  }

  static defaultProps = {
    currentProgress: 1,
    nameField: ''
  };

  componentDidMount() {
    /* Resize the order-section width to equal to the width of the order-body */
    this.resizeWidthOfSections()
    const resize = Rx.Observable.fromEvent(window, 'resize')
    resize.subscribe((event) => this.resizeWidthOfSections())
  }

  resizeWidthOfSections() {
    $('.order-body .order-section').each(function(index) {
      $(this).css('width', $('.order-body').width())
    })
    $('.order-body-wrapper').css('left', $('.order-body').width() * (-this.props.currentProgress + 1) + 'px')
  }

  slidePrevious() {
    $('.order-body-wrapper').animate({ 'left': `+=${$('.order-body').width()}px` })
  }

  slideNext() {
    $('.order-body-wrapper').animate({ 'left': `-=${$('.order-body').width()}px` })  
  }

  fieldChange(fieldName, fieldValue) {
    this.props.fieldChange(fieldName, fieldValue)
  }

  render() {
    const t = this.props.translations
    return (
      <div className="order-body">
        <div className="order-body-wrapper">
          <OrderReviewItems translations={t} />
          <OrderOrderDetails
            nameField={this.props.nameField}
            emailField={this.props.emailField}
            addressField={this.props.addressField}
            telField={this.props.telField}
            fieldChange={this.fieldChange}
            translations={t}
          />
          <OrderBillingShipping
            fieldChange={this.fieldChange}
            translations={t}
          />
          <OrderConfirm translations={t} />
        </div>
      </div>
    )
  }
}

OrderBody.propTypes = {
  currentProgress: PropTypes.number.isRequired,
  nameField: PropTypes.string,
  fieldChange: PropTypes.func.isRequired
}

export default OrderBody