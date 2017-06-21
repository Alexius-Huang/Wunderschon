import React from 'react'
import PropTypes from 'prop-types'
import OrderProgressIcon from './progress-icon'

class OrderProgressIndicator extends React.Component {
  constructor(props) {
    super(props)
  }

  static defaultProps = {
    currentProgress: 1,
    progresses: []
  }

  currentProgressTitle() {
    return this.props.progresses.filter((progress) => progress.number == this.props.currentProgress)[0].title
  }

  render() {
    const renderProgressIcon = this.props.progresses.map((progress, index) =>
      <OrderProgressIcon
        key={index}
        number={progress.number}
        active={this.props.currentProgress >= progress.number}
      />
    )
    return (
      <div className="order-progress-indicator">
        <span className="progress-title">{this.currentProgressTitle()}</span>
        <div className="order-progress-indicator-wrapper">
          {renderProgressIcon}
        </div>
      </div>
    )
  }
}

OrderProgressIndicator.propTypes = {
  currentProgress: PropTypes.number.isRequired,
  progresses: PropTypes.array.isRequired
}

export default OrderProgressIndicator