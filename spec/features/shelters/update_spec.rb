require 'rails_helper'

describe "As a user" do
  describe "when the user visits '/shelters/:id/edit' and clicks 'Update Shelter'" do
    it "the user is redirected to the 'shelters/:id' page and sees the updated information" do

      shelter_1 = Shelter.create(name: "Colorado Cares", address: "867 magnolia st", city: "Lakewood", state: "CO", zip: "80022")

      visit "/shelters/#{shelter_1.id}/edit"

      save_and_open_page
      fill_in "shelter[name]", with: "Mile High Center"
      fill_in "shelter[address]", with: "455 w first st"
      fill_in "shelter[city]", with: "Denver"

      # find('form["name=update"]').click

      # expect(click_button "Update Shelter").to route_to("/shelters/#{shelter_1.id}")
      expect(page).to have_content("Shelter ID: #{shelter_1.id}")
      expect(page).to have_content("Name: Mile High Center")
      expect(page).to have_content("Address: 455 w first st")
      expect(page).to have_content("City/State/zip: Denver, CO 80022")
    end
  end
end
