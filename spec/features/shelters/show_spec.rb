require 'rails_helper'

describe "As a user" do
  describe "when the user visits '/shelters/:id'" do
    it "the user sees the shelter's name, address, city, state, and zip and sees a link to 'Update Shelter'" do

      shelter_1 = Shelter.create(name: "Colorado Cares", address: "867 magnolia st", city: "Lakewood", state: "CO", zip: "80022")

      visit "/shelters/#{shelter_1.id}"

      expect(page).to have_content(shelter_1.name)
      expect(page).to have_content(shelter_1.address)
      expect(page).to have_content(shelter_1.city)
      expect(page).to have_content(shelter_1.state)
      expect(page).to have_content(shelter_1.zip)

      # how do you check form inputs?
      # expect(page).to have_input("Update Shelter")
    end

    xit "the user is taken to '/shelters/:id/edit' when they click 'Update Shelter'" do
      shelter_1 = Shelter.create(name: "Colorado Cares", address: "867 magnolia st", city: "Lakewood", state: "CO", zip: "80022")
      visit "/shelters/#{shelter_1.id}"

      #how to click on form inputs??
      #how to check something is routing correctly?

    end

  end
end
