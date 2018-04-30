require 'rails_helper'

RSpec.describe Product, type: :model do
  before :each do
    @category = Category.new({name:"New York"})
  end

  describe 'Validations' do
    it "should return valid" do
      @product = Product.new({name:"Supreme",description:"No comment",quantity:20,price:12.2, category:@category})
      expect(@product).to be_valid
    end

    it "should return invalid without name" do
      @product = Product.new({description:"No comment",quantity:20,price:12.2, category:@category})
      expect(@product).to be_invalid
    end

    it "should return invalid without price" do
      @product = Product.new({name:"Supreme",description:"No comment",quantity:20,category:@category})
      expect(@product).to be_invalid
    end

    it "should return invalid without quantity" do
      @product = Product.new({name:"Supreme",description:"No comment",price:12.2, category:@category})
      expect(@product).to be_invalid
    end

    it "should return invalid without category" do
      @product = Product.new({name:"Supreme",description:"No comment",quantity:20,price:12.2})
      expect(@product).to be_invalid
    end
  end
end
