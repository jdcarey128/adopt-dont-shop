require 'rails_helper'

describe "As a user" do
  describe "when the user visits '/shelters/:id/edit'" do
    xit "the user sees a pre-filled form with editable text fields for the shelter's name, address, city, state, and zip" do

      shelter_1 = Shelter.create(name: "Colorado Cares", address: "867 magnolia st", city: "Lakewood", state: "CO", zip: "80022")

      visit "/shelters/#{shelter_1.id}/edit"

      expect(page).to have_content(shelter_1.name)
      expect(page).to have_content(shelter_1.address)
      expect(page).to have_content(shelter_1.city)
      expect(page).to have_content(shelter_1.state)
      expect(page).to have_content(shelter_1.zip)

    end

    xit "the user sees the updated '/shelters/:id' upon clicking the submit button" do

    end

  end
end
