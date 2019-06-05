require 'rails_helper'

RSpec.describe 'As a registed user' do
  describe 'when I visit my profile', type: :feature do
    before :each do
      @user = create(:user)
      @address_1 = create(:address, user: @user)
      @address_2 = create(:address, user: @user)
      @address_3 = create(:address, user: @user)
      @address_4 = create(:address, user: @user)
      @order_1 = create(:order, user: @user, address: @address_2, status: "shipped")
      @order_2 = create(:order, user: @user, address: @address_3, status: "pending")
      login_as(@user)
      visit profile_path
    end

    it 'shows me a link to delete each address' do

      within("#address-#{@address_1.id}") do
        expect(page).to have_link("Delete Address")
      end

      within("#address-#{@address_2.id}") do
        expect(page).to have_link("Delete Address")
      end

      within("#address-#{@address_3.id}") do
        expect(page).to have_link("Delete Address")
      end

      within("#address-#{@address_4.id}") do
        expect(page).to have_link("Delete Address")
      end
    end

    it "allows me to delete any address not in an order" do

      within("#address-#{@address_1.id}") do
        click_on "Delete Address"
      end

      expect(current_path).to eq(profile_path)
      expect(page).to_not have_css("#address-#{@address_1.id}")
      expect(page).to_not have_content(@address_1.street)
      expect(page).to_not have_content(@address_1.city)
      expect(page).to_not have_content(@address_1.state)
      expect(page).to_not have_content(@address_1.zip)
    end

    it "allows me to delete any address in a 'pending' order" do

      within("#address-#{@address_3.id}") do
        click_on "Delete Address"
      end

      expect(current_path).to eq(profile_path)
      expect(page).to_not have_css("#address-#{@address_3.id}")
      expect(page).to_not have_content(@address_3.street)
      expect(page).to_not have_content(@address_3.city)
      expect(page).to_not have_content(@address_3.state)
      expect(page).to_not have_content(@address_3.zip)
    end

    it "will not allow me to delete an address used in an order" do

      within "#address-#{@address_2.id}" do
        click_on "Delete Address"
      end

      message = "This address cannot be deleted due to its inclusion in a previous order."

      expect(page).to have_content(message)
      within "#address-#{@address_2.id}" do
        expect(page).to have_content(@address_2.nickname)
        expect(page).to have_content(@address_2.street)
        expect(page).to have_content(@address_2.city)
        expect(page).to have_content(@address_2.state)
        expect(page).to have_content(@address_2.zip)
      end
    end
  end
end
