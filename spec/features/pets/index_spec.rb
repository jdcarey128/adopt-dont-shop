require 'rails_helper'

RSpec.describe "As a user" do
  describe "when I visit the '/pets' webpage" do
    it "I see each Pet including their image, name, approximate age, sex, and name of shelter" do
      shelter_1 = Shelter.create(name: "Colorado Cares", address: "867 magnolia st", city: "Lakewood", state: "CO", zip: "80022")
      shelter_2 = Shelter.create(name: "Rocky Mountain High", address: "1234 fake st.", city: "Denver", state: "CO", zip: "45505")
      pet_1 = shelter_1.pets.create(image: "https://dogtime.com/assets/uploads/gallery/austalian-shepherd-dog-breed-pictures/10-threequarters.jpg",
                        name: "Tony",
                        approximate_age: "2",
                        sex: "male")
      pet_2 = shelter_2.pets.create(image: "https://dogtime.com/assets/uploads/gallery/german-shorthaired-pointer-dogs-and-puppies/german-shorthaired-pointer-dogs-puppies-3.jpg",
                                    name: "Isabell",
                                    approximate_age: "5",
                                    sex: "female")
      visit '/pets'

      # within(".pet_#{pet_1.id}") do
        expect(page).to have_xpath("//img[contains(@src, '#{pet_1.image}')]")
        expect(page).to have_content(pet_1.name)
        expect(page).to have_content(pet_1.approximate_age)
        expect(page).to have_content(pet_1.sex)
        expect(page).to have_content(pet_1.shelter.name)
      # end

      # within(".pet_#{pet_2.id}") do
        expect(page).to have_xpath("//img[contains(@src, '#{pet_2.image}')]")
        expect(page).to have_content(pet_2.name)
        expect(page).to have_content(pet_2.approximate_age)
        expect(page).to have_content(pet_2.sex)
        expect(page).to have_content(pet_2.shelter.name)
      # end

    end
  end
end
