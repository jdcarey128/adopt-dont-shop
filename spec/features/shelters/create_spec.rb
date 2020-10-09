require 'rails_helper'

describe "As a user" do
  describe "when the user visits '/shelters/new'" do
    it "the user sees an empty form to complete the shelter's name, address, city, state, and zip do" do

      visit '/shelters/new'

      expect(page).to have_content("Name")
      expect(find_field("shelter[name]").value).to eq(nil)

      expect(page).to have_content("Address")
      expect(find_field("shelter[address]").value).to eq(nil)

      expect(page).to have_content("City")
      expect(find_field("shelter[city]").value).to eq(nil)

      expect(page).to have_content("State")
      expect(find_field("shelter[state]").value).to eq(nil)

      expect(page).to have_content("Zip")
      expect(find_field("shelter[zip]").value).to eq(nil)

    end

    it "the user submits a new form and sees the new shelter on '/shelters'" do
      visit '/shelters/new'

      fill_in "shelter[name]", with: "Mile High Cares"
      fill_in "shelter[address]", with: "4550 north st"
      fill_in "shelter[city]", with: "Denver"
      fill_in "shelter[state]", with: "CO"
      fill_in "shelter[zip]", with: "80219"

      click_button("Create Shelter")
      expect(page).to have_content("Mile High Cares")
      
    end


  end
end
