import React from 'react'
import PropTypes from 'prop-types'

class OrderFooter extends React.Component {
  constructor(props) {
    super(props)
    this.handlePreviousStepClick = this.handlePreviousStepClick.bind(this)
    this.handleNextStepClick = this.handleNextStepClick.bind(this)
  }

  static defaultProps = {
    totalProgress: NaN,
    currentProgress: 1
  }

  previousStepBtnClass() {
    return this.props.currentProgress === 1 ? 'btn disabled' : 'btn'
  }

  nextStepBtnClass() {
    return this.props.currentProgress === this.props.totalProgress ? 'btn disabled' : 'btn'
  }

  handlePreviousStepClick(event) {
    event.preventDefault()
    this.props.previousStep(true)
  }

  handleNextStepClick(event) {
    event.preventDefault()
    this.props.nextStep(true)
  }

  render() {
    const t = this.props.translations
    return (
      <div className="order-footer">
        <button
          className={this.previousStepBtnClass()}
          id="previous-step-btn"
          onClick={this.handlePreviousStepClick}
        >{t.footer.previous_step}</button>
        <button
          className={this.nextStepBtnClass()}
          id="next-step-btn"
          onClick={this.handleNextStepClick}
        >{t.footer.next_step}</button>
      </div>
    )
  }
}

OrderFooter.propTypes = {
  currentProgress: PropTypes.number.isRequired,
  totalProgress: PropTypes.number.isRequired,
  previousStep: PropTypes.func.isRequired,
  nextStep: PropTypes.func.isRequired
}

export default OrderFooter