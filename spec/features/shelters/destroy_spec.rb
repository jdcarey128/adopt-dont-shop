require 'rails_helper'

describe "As a user" do
  describe "when the user visits '/shelters/:id'" do
    it "the user sees a link to delete the shelter" do

      shelter_1 = Shelter.create(name: "Colorado Cares", address: "867 magnolia st", city: "Lakewood", state: "CO", zip: "80022")
      visit "/shelters/#{shelter_1.id}"

      # save_and_open_page
      expect(page).to have_link("Delete Shelter")
    end

    xit "the user is redirected to the '/shelters' page and no longer sees the deleted shelter upon click the 'Delet Shelter' link" do
    end


  end
end
