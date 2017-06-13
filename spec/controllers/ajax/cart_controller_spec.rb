# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Ajax::CartController, type: :controller do
  let(:product_item_array) do
    items_array = []
    5.times { items_array.push(product: create(:product), quantity: rand(3..10)) }
    items_array
  end
  let(:cart)                { Cart.new product_item_array }
  let(:cart_hash)           { cart.to_hash }
  let(:new_product)         { create(:product) }
  let(:sample_product_hash) { product_item_array.sample }
  let(:sample_product)      { sample_product_hash[:product] }
  let(:sample_quantity)     { sample_product_hash[:quantity] }
  let(:quantity)            { rand(2..(sample_quantity - 1)) }

  def post_action(action, params, session = { cart: cart_hash }, format = :json)
    post action, format: format, params: params, session: session
  end

  describe '.add_product' do
    context 'new product' do
      it 'should add new cart item to cart hash session which quantity is one by default ' do
        post_action :add_product, product_id: new_product.id
        expect(session[:cart]['items']).to include('product_id' => new_product.id, 'quantity' => 1, 'price' => new_product.price)
        expect(session[:cart]['items'].count).to eq product_item_array.size.next
        expect(JSON.parse(response.body)['status']).to eq 200
      end

      it 'should add new cart item to cart hash session which stored quantity with params[:quantity]' do
        post_action :add_product, product_id: new_product.id, quantity: quantity
        expect(session[:cart]['items']).to include('product_id' => new_product.id, 'quantity' => quantity, 'price' => new_product.price)
        expect(session[:cart]['items'].count).to eq product_item_array.size.next
        expect(JSON.parse(response.body)['status']).to eq 200
      end
    end

    context 'product already in cart' do
      it 'should add quantity of one by default' do
        post_action :add_product, product_id: sample_product.id
        expect(session[:cart]['items']).to include('product_id' => sample_product.id, 'quantity' => sample_quantity.next, 'price' => sample_product.price)
        expect(session[:cart]['items'].count).to eq product_item_array.size
        expect(JSON.parse(response.body)['status']).to eq 200
      end

      it 'should add quantity with the amount which specified with params[:quantity]' do
        post_action :add_product, product_id: sample_product.id, quantity: quantity
        expect(session[:cart]['items']).to include('product_id' => sample_product.id, 'quantity' => sample_quantity + quantity, 'price' => sample_product.price)
        expect(session[:cart]['items'].count).to eq product_item_array.size
        expect(JSON.parse(response.body)['status']).to eq 200
      end
    end

    context 'invalid' do
      # #61 TODO: Rescuing the Invalid Case of the AJAX Request
      it '#61 should rescue the invalid case of the Ajax#CartController.add_item'
    end
  end

  describe '.delete_product' do
    it 'should deduct quantity default by one' do
      post_action :delete_product, product_id: sample_product.id
      expect(session[:cart]['items']).to include('product_id' => sample_product.id, 'quantity' => sample_quantity - 1, 'price' => sample_product.price)
      expect(session[:cart]['items'].count).to eq product_item_array.size
      expect(JSON.parse(response.body)['status']).to eq 200
    end

    it 'should deduct quantity with amount specified with params[:quantity]' do
      post_action :delete_product, product_id: sample_product.id, quantity: quantity
      expect(session[:cart]['items']).to include('product_id' => sample_product.id, 'quantity' => sample_quantity - quantity, 'price' => sample_product.price)
      expect(session[:cart]['items'].count).to eq product_item_array.size
      expect(JSON.parse(response.body)['status']).to eq 200
    end

    it 'should remove item entirely from hash when quantity is deduct to zero' do
      post_action :delete_product, product_id: sample_product.id, quantity: sample_quantity
      expect(session[:cart]['items']).not_to include('product_id' => sample_product.id, 'quantity' => 0, 'price' => sample_product.price)
      expect(session[:cart]['items'].count).to eq product_item_array.size - 1
      expect(JSON.parse(response.body)['status']).to eq 200
    end

    context 'invalid' do
      # #61 TODO: Rescuing the Invalid Case of the AJAX Request
      it '#61 should rescue the invalid case of the Ajax#CartController.delete_item'
    end
  end

  describe '.get_data' do
    let(:cart_info) do
      {
        'total_price' => cart.total_price,
        'empty' => false,
        'item_count' => cart.cart_items.count,
        'items' => cart.cart_items.map(&:info)
      }
    end

    it 'should at least have certain key data type of the cart' do
      get :get_data, format: :json, session: { cart: cart_hash }
      body = JSON.parse(response.body)
      expect(body.key?('total_price')).to be_truthy
      expect(body.key?('empty')).to       be_truthy
      expect(body.key?('item_count')).to  be_truthy
      expect(body.key?('items')).to       be_truthy
      expect(body['total_price']).to      be_kind_of Integer
      expect(body['empty']).to            be_kind_of FalseClass
      expect(body['item_count']).to       be_kind_of Integer
      expect(body['items']).to            be_kind_of Array
    end
  end
end
