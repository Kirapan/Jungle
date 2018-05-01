require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'After creation' do
    before :each do
      @category = Category.new({name:"New York"})
      # Setup at least two products with different quantities, names, etc
      @product1 = Product.create!({name:"Supreme",description:"No comment",quantity:20,price:12.2, category:@category})
      @product2 = Product.create!({name:"Acne Studio",description:"Fashion",quantity:10,price:20.2, category:@category})
      # Setup at least one product that will NOT be in the order
    end
    # pending test 1
    it 'deducts quantity from products based on their line item quantities' do
      # TODO: Implement based on hints below
      # 1. initialize order with necessary fields (see orders_controllers, schema and model definition for what is required)
      @order = Order.new({total:12.2, email:"ab@gmail.com",stripe_charge_id:1})
      # 2. build line items on @order
      @order.line_items.new({product: @product1,quantity: 1, item_price: 12.2, total_price: 12.2})
      # 3. save! the order - ie raise an exception if it fails (not expected)
      @order.save!
      # 4. reload products to have their updated quantities
      @product1.reload
      @product2.reload
      # 5. use RSpec expect syntax to assert their new quantity values
      expect(@product1.quantity).to eq(19)
    end
    # pending test 2
    it 'does not deduct quantity from products that are not in the order' do
      # TODO: Implement based on hints in previous test
      expect(@product2.quantity).to eq(10)
    end
  end
end
