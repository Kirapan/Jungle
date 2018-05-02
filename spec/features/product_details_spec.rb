require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
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

  scenario "As a user I want to see the product detail" do
    visit product_path

    expect(page).to have_content "Product details"
    expect(page).to have_content product.name
    expect(page).to have_content product.description
    expect(page).to have_content product.image
    expect(page).to have_content product.quantity
    expect(page).to have_content product.price
  end
end
