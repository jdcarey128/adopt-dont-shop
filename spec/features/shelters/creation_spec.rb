require 'rails_helper'

describe "As a user" do
  describe "when the user visits '/shelters/new'" do
    it "the user sees a form to complete the shelter's name, address, city, state, and zip do" do

      visit '/shelters/new'

      expect(page).to have_content("Name")
      expect(page).to have_content("Address")
      expect(page).to have_content("City")
      expect(page).to have_content("State")
      expect(page).to have_content("Zip")
    end
  end
end
