import React from 'react'

class ShoppingCartCaption extends React.Component {
  constructor(props) {
    super(props)
  }

  render() {
    const t = this.props.translations
    return (
      <div className="shopping-cart-caption">
        <div className="row">
          <div className="col-xl-2 col-lg-2 col-md-2 col-xs-2">
            {t.caption.img}
          </div>
          <div className="col-xl-4 col-lg-4 col-md-4 col-xs-4">
            {t.caption.title}
          </div>
          <div className="col-xl-2 col-lg-2 col-md-2 col-xs-2">
            {t.caption.price}
          </div>
          <div className="col-xl-2 col-lg-2 col-md-2 col-xs-2">
            {t.caption.quantity}
          </div>
          <div className="col-xl-2 col-lg-2 col-md-2 col-xs-2">
            {t.caption.total_price}
          </div>
        </div>
      </div>
    )
  }
}

export default ShoppingCartCaption