require 'rails_helper'

RSpec.feature "View Product Details", type: :feature, js: true do
   # SETUP
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

  scenario "Can view product details" do
    # ACT
    visit root_path
    first(".product").click_on('Details')

    # VERIFY
    expect(page).to have_content "Quantity"
    
    # DEBUG
    save_screenshot
    
  end
end
