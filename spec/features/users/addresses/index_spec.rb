require 'rails_helper'

RSpec.describe 'As a registed user' do
  describe 'when I visit my profile', type: :feature do
    before :each do
      @user = create(:user)
      @address_1 = create(:address, user: @user)
      @address_2 = create(:address, user: @user)
      @address_3 = create(:address, user: @user)
      @address_4 = create(:address, user: @user)
      login_as(@user)
    end

    it 'shows an index of all of my addresses' do
      visit profile_path

      within("#address-#{@address_1.id}") do
        expect(page).to have_content(@address_1.nickname)
        expect(page).to have_content(@address_1.street)
        expect(page).to have_content(@address_1.city)
        expect(page).to have_content(@address_1.state)
        expect(page).to have_content(@address_1.zip)
      end

      within("#address-#{@address_2.id}") do
        expect(page).to have_content(@address_2.nickname)
        expect(page).to have_content(@address_2.street)
        expect(page).to have_content(@address_2.city)
        expect(page).to have_content(@address_2.state)
        expect(page).to have_content(@address_2.zip)
      end

      within("#address-#{@address_3.id}") do
        expect(page).to have_content(@address_3.nickname)
        expect(page).to have_content(@address_3.street)
        expect(page).to have_content(@address_3.city)
        expect(page).to have_content(@address_3.state)
        expect(page).to have_content(@address_3.zip)
      end

      within("#address-#{@address_4.id}") do
        expect(page).to have_content(@address_4.nickname)
        expect(page).to have_content(@address_4.street)
        expect(page).to have_content(@address_4.city)
        expect(page).to have_content(@address_4.state)
        expect(page).to have_content(@address_4.zip)
      end
    end
  end

  describe "when I don't have any addresses" do
    before :each do
      user = create(:user)
      login_as(user)
      item = create(:item)
      visit item_path(item)
      click_on "Add to Cart"
    end

    it "won't allow me to checkout" do
      visit cart_path

      expect(page).to have_content("You must provide an address to checkout.")
    end
  end
end
