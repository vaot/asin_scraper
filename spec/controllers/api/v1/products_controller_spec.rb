require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :controller do
  describe 'GET show' do
    context 'when product exists' do
      before :each do
        @product = Product.create(asin: "myasin")
        get :show, params: { id: "myasin" }
      end

      it 'returns the product' do
        expect(JSON.parse(response.body)["id"]).to eq(@product.id)
      end
    end

    context 'when product doesnt exist' do
      before :each do
        get :show, params: { id: "myasin" }
      end

      it 'returns 404' do
        expect(response).to be_not_found
      end
    end
  end

  describe 'GET index' do
    context 'when products exist' do
      before :each do
        @products = (1..10).map { |i| Product.create(asin: "myasin_#{i}") }
        # Make half of then active
        @products[5..-1].each { |o| o.active! }
        get :index
      end

      it 'returns all active products' do
        expect(JSON.parse(response.body).count).to eq(5)
      end
    end

    context 'when products dont exist' do
      before :each do
        get :index
      end

      it 'returns empty array' do
        expect(JSON.parse(response.body)).to eq([])
      end
    end
  end

  describe 'GET fetch' do
    context 'with invalid asin number' do
      before :each do
        # ASIN should be 10 chars length
        get :fetch, params: { id: "wrongasin" }
      end

      it 'returns a bad request' do
        expect(response).to be_bad_request
      end
    end

    context 'new product' do
      before :each do
        get :fetch, params: { id: "0123456789" }
      end

      it 'retrieves a new product' do
        expect(JSON.parse(response.body)["id"]).to eq(1)
      end
    end

    context 'existing product' do
      before :each do
        @product = Product.create(asin: "0123456789")
        get :fetch, params: { id: "0123456789" }
      end

      it 'retrieves a new product' do
        expect(JSON.parse(response.body)["id"]).to eq(@product.id)
      end
    end
  end

  describe 'DELETE destroy' do
    context 'when products exist' do
      before :each do
        @product = Product.create(asin: "0123456789")
        delete :destroy, params: { id: "0123456789" }
      end

      it 'should delete record' do
        expect(Product.count).to eq(0)
      end
    end

    context 'when products dont exist' do
      before :each do
        delete :destroy, params: { id: "0123456789" }
      end

      it 'returns not_found' do
        expect(response).to be_not_found
      end
    end
  end
end
