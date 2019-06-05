require 'rails_helper'

RSpec.describe 'As a registed user' do
  describe 'when I visit my profile', type: :feature do
    before :each do
      user = create(:user)
      login_as(user)
    end

    it 'allows the user to go to an add address form' do
      visit profile_path

      click_link("Add New Address")

      expect(current_path).to eq(new_profile_address_path)
    end

    it "allows the user to add a new address" do
      visit new_profile_address_path

      fill_in :address_nickname, with: "Memorial"
      fill_in :address_street, with: "13818 St. Mary's Ln."
      fill_in :address_city, with: "Houston"
      fill_in :address_state, with: "Texas"
      fill_in :address_zip, with: "77079"

      click_button "Submit"

      expect(current_path).to eq(profile_path)

      expect(page).to have_content("Memorial")
      expect(page).to have_content("13818 St. Mary's Ln.")
      expect(page).to have_content("Houston")
      expect(page).to have_content("Texas")
      expect(page).to have_content("77079")
    end
  end
end
