import React from 'react'
import PropTypes from 'prop-types'

class ShoppingCartHeader extends React.Component {
  constructor(props) {
    super(props)
  }

  static defaultProps = {
    totalPrice: 0,
    empty: true
  };

  render() {
    const t = this.props.translations
    return (
      <div className="shopping-cart-header">
        <div className="row">
          <div className="col-xl-6 col-lg-6 col-md-6 col-sm-6">
            {t.header.app_name}
          </div>
          <div className="col-xl-6 col-lg-6 col-md-6 col-sm-6 text-right">
            {t.header.total_price} ${this.props.totalPrice}
          </div>
        </div>
      </div>
    )
  }
}

ShoppingCartHeader.propTypes = {
  totalPrice: PropTypes.number.isRequired,
  empty: PropTypes.bool.isRequired
}

export default ShoppingCartHeader