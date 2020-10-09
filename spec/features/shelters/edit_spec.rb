require 'rails_helper'

describe "As a user" do
  describe "when the user visits '/shelters/:id/edit'" do
    it "the user sees a pre-filled form with editable text fields for the shelter's name, address, city, state, and zip" do
      shelter_1 = Shelter.create(name: "Colorado Cares", address: "867 magnolia st", city: "Lakewood", state: "CO", zip: "80022")

      visit "/shelters/#{shelter_1.id}/edit"

      save_and_open_page

      expect(find_field("shelter[name]").value).to eq(shelter_1.name)
      expect(find_field("shelter[address]").value).to eq(shelter_1.address)
      expect(find_field("shelter[city]").value).to eq(shelter_1.city)
      expect(find_field("shelter[state]").value).to eq(shelter_1.state)
      expect(find_field("shelter[zip]").value).to eq(shelter_1.zip)
    end

    it "the user is redirected to the 'shelters/:id' page and sees the updated information" do
      shelter_1 = Shelter.create(name: "Colorado Cares", address: "867 magnolia st", city: "Lakewood", state: "CO", zip: "80022")

      visit "/shelters/#{shelter_1.id}/edit"

      expect(find_field("shelter[name]").value).to eq(shelter_1.name)
      expect(find_field("shelter[address]").value).to eq(shelter_1.address)
      expect(find_field("shelter[city]").value).to eq(shelter_1.city)
      expect(find_field("shelter[state]").value).to eq(shelter_1.state)
      expect(find_field("shelter[zip]").value).to eq(shelter_1.zip)

      fill_in "shelter[name]", with: "Mile High Center"
      fill_in "shelter[address]", with: "455 w first st"
      fill_in "shelter[city]", with: "Denver"

      click_button("Update Shelter")
      expect(current_path).to eq("/shelters/#{shelter_1.id}")

      expect(page).to have_content("Name: Mile High Center")
      expect(page).to have_content("Address: 455 w first st")
      expect(page).to have_content("City/State/zip: Denver, CO 80022")
    end
  end

end
