require 'rails_helper'

RSpec.feature "Purchase Gift", type: :feature do
  scenario "Creates an order then creates a gift order for same child" do
    product = Product.create!(
      name: "product1",
      description: "description2",
      price_cents: 1000,
      age_low_weeks: 0,
      age_high_weeks: 12,
    )

    visit "/"

    within ".products-list .product" do
      click_on "More Details…"
    end

    click_on "Buy Now $10.00"

    fill_in "order[credit_card_number]", with: "4111111111111111"
    fill_in "order[expiration_month]", with: 12
    fill_in "order[expiration_year]", with: 25
    fill_in "order[shipping_name]", with: "Pat Jones"
    fill_in "order[address]", with: "123 Any St"
    fill_in "order[zipcode]", with: 83701
    fill_in "order[child_full_name]", with: "Kim Jones"
    fill_in "order[child_birthdate]", with: "2019-03-03"

    click_on "Purchase"

    expect(page).to have_content("Thanks for Your Order")
    expect(page).to have_content(Order.last.user_facing_id)
    expect(page).to have_content("Kim Jones")


    # Beginning of gift order

    visit "/"

    within ".products-list .product" do
      click_on "More Details…"
    end

    click_on "Send Gift $10.00"

    fill_in "gift[credit_card_number]", with: "4111111111111111"
    fill_in "gift[expiration_month]", with: 12
    fill_in "gift[expiration_year]", with: 25
    fill_in "gift[shipping_name]", with: "Peter Parker"
    fill_in "gift[parent_name]", with: "Pat Jones"
    fill_in "gift[child_full_name]", with: "Kim Jones"
    fill_in "gift[child_birthdate]", with: "2019-03-03"
    fill_in "gift[message]", with: "Enjoy Kimmie!"

    click_on "Purchase"

    expect(page).to have_content("Thanks for Your Order")
    expect(page).to have_content(Order.last.user_facing_id)
    expect(page).to have_content("Kim Jones")
    expect(page).to have_content("Enjoy Kimmie!")


  end

  scenario "Creates an order then creates a gift order for different child" do
    product = Product.create!(
      name: "product1",
      description: "description2",
      price_cents: 1000,
      age_low_weeks: 0,
      age_high_weeks: 12,
    )

    visit "/"

    within ".products-list .product" do
      click_on "More Details…"
    end

    click_on "Buy Now $10.00"

    fill_in "order[credit_card_number]", with: "4111111111111111"
    fill_in "order[expiration_month]", with: 12
    fill_in "order[expiration_year]", with: 25
    fill_in "order[shipping_name]", with: "Pat Jones"
    fill_in "order[address]", with: "123 Any St"
    fill_in "order[zipcode]", with: 83701
    fill_in "order[child_full_name]", with: "Kim Jones"
    fill_in "order[child_birthdate]", with: "2019-03-03"

    click_on "Purchase"

    expect(page).to have_content("Thanks for Your Order")
    expect(page).to have_content(Order.last.user_facing_id)
    expect(page).to have_content("Kim Jones")


    # Beginning of gift order

    visit "/"

    within ".products-list .product" do
      click_on "More Details…"
    end

    click_on "Send Gift $10.00"

    fill_in "gift[credit_card_number]", with: "4111111111111111"
    fill_in "gift[expiration_month]", with: 12
    fill_in "gift[expiration_year]", with: 25
    fill_in "gift[shipping_name]", with: "Peter Parker"
    fill_in "gift[parent_name]", with: "Pat Jones"
    fill_in "gift[child_full_name]", with: "Brandon Jones"
    fill_in "gift[child_birthdate]", with: "2019-03-03"
    fill_in "gift[message]", with: "Enjoy Kimmie!"

    click_on "Purchase"

    expect(page).not_to have_content("Thanks for Your Order")
    expect(page).to have_content("Child must exist")


  end
end
