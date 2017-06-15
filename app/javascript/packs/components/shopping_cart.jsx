import React from 'react'
import PropTypes from 'prop-types'
// import Axios from 'axios'
import ShoppingCartIcon from './shopping_cart/shopping_cart_icon'

class ShoppingCart extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      itemCount: 0
    }
    this.setupAddProductToCartEvent();
  }
  
  componentWillMount() {
    this.getCartInfo().then(response => {
      this.setState({ itemCount: response.data.item_count })
    })
  }

  setupAddProductToCartEvent(url = '/ajax/cart/add_product.json') {
    let buttonEventEmitter = (observer) => {
      $('.custom-container').on('click', 'a.add-cart-item-btn', function(event) {
        event.preventDefault()
        observer.next($(this))
      })
    }
    let getProductId = el => el.data('id')
    let addCartItem = (productId) => Axios.post(url, { product_id: productId })
    let resolved = (request) => {
      request.then((response) => {
        /* Response Here */
        if (response.data.status === 200) {
          this.updateCartInfo();
        }
      })
    }

    let source = Rx.Observable.create(buttonEventEmitter)
    source
      .map(getProductId)
      .map(addCartItem)
      .subscribe(resolved)
  }

  getCartInfo(url = '/ajax/cart/info.json') {
    return Axios.get(url)
  }

  updateCartInfo() {
    this.getCartInfo().then(response => {
      this.setState({ itemCount: response.data.item_count })
    })
  }

  render() {
    return (
      <div className="shopping-cart">
        <ShoppingCartIcon itemCount={this.state.itemCount} />
      </div>
    )
  }
}

// Hello.defaultProps = {
//   name: 'David'
// }

// Hello.propTypes = {
//   name: PropTypes.string
// }

export default ShoppingCart