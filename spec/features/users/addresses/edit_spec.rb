require 'rails_helper'

RSpec.describe 'As a registed user' do
  describe 'when I visit my profile', type: :feature do
    before :each do
      @user = create(:user)
      @address = create(:address, user: @user)
      login_as(@user)
    end

    it 'allows the user to go to an edit address form' do
      visit profile_path

      within "#address-#{@address.id}" do
        click_link("Edit Address")
      end

      expect(current_path).to eq(edit_profile_address_path(@address.id))
    end

    it "allows the user to add a new address" do
      visit edit_profile_address_path(@address.id)

      fill_in :address_nickname, with: "Memorial"
      fill_in :address_street, with: "13818 St. Mary's Lane"
      fill_in :address_city, with: "Houston"
      fill_in :address_state, with: "Texas"
      fill_in :address_zip, with: "77079"

      click_button "Submit"

      expect(current_path).to eq(profile_path)

      expect(page).to have_content("Memorial")
      expect(page).to have_content("13818 St. Mary's Lane")
      expect(page).to have_content("Houston")
      expect(page).to have_content("Texas")
      expect(page).to have_content("77079")
    end
  end
end
