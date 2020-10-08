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

    xit "the user submits a new form and sees the new shelter on '/shelters'" do
      visit '/shelters/new'
      fill_in "shelter[name]", with: "Mile High Cares"
      fill_in "shelter[address]", with: "4550 north st"
      fill_in "shelter[city]", with: "Denver"
      fill_in "shelter[state]", with: "CO"
      fill_in "shelter[zip]", with: "80219"

      click_button("Create Shelter")
      expect(page).to have_content("Mile High Cares")
      expect(page).to have_content("4550 north st")
      expect(page).to have_content("Denver")
      expect(page).to have_content("CO")
      expect(page).to have_content("80219")

    end


  end
end
