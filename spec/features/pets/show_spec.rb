require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "when I visit '/pets/:id'" do
    it "I see the pet's image, name, description, approximate age, sex, and adoption status" do
      shelter_1 = Shelter.create(name: "Colorado Cares", address: "867 magnolia st", city: "Lakewood", state: "CO", zip: "80022")
      pet_1 = shelter_1.pets.create(image: "https://dogtime.com/assets/uploads/gallery/austalian-shepherd-dog-breed-pictures/10-threequarters.jpg",
                        name: "Tony",
                        approximate_age: "2",
                        sex: "male")
      visit "/pets/#{pet_1.id}"

      expect(page).to have_xpath("//img [contains(@src, '#{pet_1.image}')]")
      expect(page).to have_content(pet_1.name)
      expect(page).to have_content(pet_1.approximate_age)
      expect(page).to have_content(pet_1.sex)
      expect(page).to have_content(pet_1.shelter.name)
    end
  end
end
