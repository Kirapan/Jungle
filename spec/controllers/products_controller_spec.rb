require 'rails_helper'

RSpec.describe ProductsController, type: :controller do

  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  describe "#show"
    it 'returns 200 response' do
      get :product
      expect(response).to have_http_status(:ok)
      .and_return(:product)

    end
end
