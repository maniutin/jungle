require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
   it 'saves a product with all four fields set' do
    @category = Category.create(name: 'Art Supplies')
    @product = Product.create(name: 'Brush', price: '20', quantity: '10', category: @category)
    expect(@product).to be_present
   end

   it 'does not save without name' do
    @category = Category.create(name: 'Art Supplies')
    @product = Product.create(name: nil, price: '20', quantity: '10', category: @category)
    expect(@product.errors.full_messages).to include "Name can't be blank"
   end

   it 'does not save without price' do
    @category = Category.create(name: 'Art Supplies')
    @product = Product.create(name: 'Brush', price: nil, quantity: '10', category: @category)
    expect(@product.errors.full_messages).to include "Price can't be blank"
   end

   it 'does not save without quantity' do
    @category = Category.create(name: 'Art Supplies')
    @product = Product.create(name: 'Brush', price: '20', quantity: nil, category: @category)
    expect(@product.errors.full_messages).to include "Quantity can't be blank"
   end

   it 'does not save without category' do
    @category = Category.create(name: 'Art Supplies')
    @product = Product.create(name: 'Brush', price: '20', quantity: '10', category: nil)
    expect(@product.errors.full_messages).to include "Category can't be blank"
   end
  end
end
