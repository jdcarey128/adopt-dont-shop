require 'rails_helper'

RSpec.describe "As a user" do
  describe "when I visit '/shelters/:sheter_id/pets'" do
    it "I see each pet's image, name, approximate age, and sex that can be adopted from that shelter" do
      shelter_1 = Shelter.create(name: "Colorado Cares", address: "867 magnolia st", city: "Lakewood", state: "CO", zip: "80022")
      shelter_2 = Shelter.create(name: "Rocky Mountain High", address: "1234 fake st.", city: "Denver", state: "CO", zip: "45505")
      pet_1 = shelter_1.pets.create(image: "https://dogtime.com/assets/uploads/gallery/austalian-shepherd-dog-breed-pictures/10-threequarters.jpg",
                        name: "Tony",
                        approximate_age: "2",
                        sex: "male",
                        description: "Pretty cute as far as dogs go.")
      pet_2 = shelter_2.pets.create(image: "https://dogtime.com/assets/uploads/gallery/german-shorthaired-pointer-dogs-and-puppies/german-shorthaired-pointer-dogs-puppies-3.jpg",
                                    name: "Isabell",
                                    approximate_age: "5",
                                    sex: "female",
                                    description: "Pretty cute as far as dogs go.")
      visit "/shelters/#{shelter_1.id}/pets"

      expect(page).to have_xpath("//img[contains(@src, '#{pet_1.image}')]")
      expect(page).to have_content(pet_1.name)
      expect(page).to have_content(pet_1.approximate_age)
      expect(page).to have_content(pet_1.sex)
      expect(page).to have_content(pet_1.shelter.name)

      expect(page).to_not have_xpath("//img[contains(@src, '#{pet_2.image}')]")
      expect(page).to_not have_content(pet_2.name)
      expect(page).to_not have_content(pet_2.approximate_age)
      expect(page).to_not have_content(pet_2.sex)
      expect(page).to_not have_content(pet_2.shelter.name)
    end

    describe "user story 15/16" do
      it "I can edit each pet's information" do
        shelter_1 = Shelter.create(name: "Colorado Cares", address: "867 magnolia st", city: "Lakewood", state: "CO", zip: "80022")
        shelter_2 = Shelter.create(name: "Rocky Mountain High", address: "1234 fake st.", city: "Denver", state: "CO", zip: "45505")
        pet_1 = shelter_1.pets.create(image: "https://dogtime.com/assets/uploads/gallery/austalian-shepherd-dog-breed-pictures/10-threequarters.jpg",
                          name: "Tony",
                          approximate_age: "2",
                          sex: "male",
                          description: "He is just adorable!")
        pet_2 = shelter_2.pets.create(image: "https://dogtime.com/assets/uploads/gallery/german-shorthaired-pointer-dogs-and-puppies/german-shorthaired-pointer-dogs-puppies-3.jpg",
                                      name: "Isabell",
                                      approximate_age: "5",
                                      sex: "female",
                                      description: "Just the cutest!")

        visit "/shelters/#{shelter_1.id}/pets"

        within("#pet_#{pet_1.id}") do
          expect(page).to have_link("edit pet")
          click_link("edit pet")
        end

        expect(current_path).to eq("/shelters/#{shelter_1.id}/pets/#{pet_1.id}/edit")
        expect(find_field("image").value).to eq(pet_1.image)
        expect(find_field("name").value).to eq(pet_1.name)
        expect(find_field("description").value).to eq(pet_1.description)
        expect(find_field("approximate_age").value).to eq(pet_1.approximate_age)
        expect(find_field("sex").value).to eq(pet_1.sex)

        fill_in "name", with: "Rebecca"
        fill_in "approximate_age", with: "3"
        fill_in "sex", with: "female"

        click_on("Update Pet")
        expect(current_path).to eq("/shelters/#{shelter_1.id}/pets")

        within("#pet_#{pet_1.id}") do
          expect(page).to have_content("Rebecca")
          expect(page).to_not have_content("Tony")
          expect(page).to have_content("Approximate age: 3")
          expect(page).to_not have_content("Approximate age: 2")
          expect(page).to have_content("Sex: female")
          expect(page).to_not have_content("Sex: male", exact:true)
        end


        visit "/shelters/#{shelter_2.id}/pets"

        within("#pet_#{pet_2.id}") do
          expect(page).to have_link("edit pet")
          click_link("edit pet")
        end

        expect(current_path).to eq("/shelters/#{shelter_2.id}/pets/#{pet_2.id}/edit")
        expect(find_field("image").value).to eq(pet_2.image)
        expect(find_field("name").value).to eq(pet_2.name)
        expect(find_field("description").value).to eq(pet_2.description)
        expect(find_field("approximate_age").value).to eq(pet_2.approximate_age)
        expect(find_field("sex").value).to eq(pet_2.sex)
      end

      it "I can delete the pet" do
        shelter_1 = Shelter.create(name: "Colorado Cares", address: "867 magnolia st", city: "Lakewood", state: "CO", zip: "80022")
        pet_1 = shelter_1.pets.create(image: "https://dogtime.com/assets/uploads/gallery/austalian-shepherd-dog-breed-pictures/10-threequarters.jpg",
                          name: "Tony",
                          approximate_age: "2",
                          sex: "male",
                          description: "He is just adorable!")
        pet_2 = shelter_1.pets.create(image: "https://dogtime.com/assets/uploads/gallery/german-shorthaired-pointer-dogs-and-puppies/german-shorthaired-pointer-dogs-puppies-3.jpg",
                                      name: "Isabell",
                                      approximate_age: "5",
                                      sex: "female",
                                      description: "Just the cutest!")

        visit "/shelters/#{shelter_1.id}/pets"

        expect(page).to have_xpath("//img[contains(@src, '#{pet_1.image}')]")
        expect(page).to have_content(pet_1.name)
        expect(page).to have_content(pet_1.approximate_age)
        expect(page).to have_content(pet_1.sex)
        expect(page).to have_content(pet_1.shelter.name)

        within("#pet_#{pet_1.id}") do
          expect(page).to have_link("delete pet")
          click_link("delete pet")
        end

        expect(current_path).to eq("/shelters/#{shelter_1.id}/pets")

        expect(page).to_not have_xpath("//img[contains(@src, '#{pet_1.image}')]")
        expect(page).to_not have_content(pet_1.name)
        expect(page).to_not have_content(pet_1.approximate_age)
        expect(page).to_not have_content(pet_1.sex, exact:true)

        expect(page).to have_xpath("//img[contains(@src, '#{pet_2.image}')]")
        expect(page).to have_content(pet_2.name)
        expect(page).to have_content(pet_2.approximate_age)
        expect(page).to have_content(pet_2.sex)
        expect(page).to have_content(pet_2.shelter.name)

        within("#pet_#{pet_2.id}") do
          expect(page).to have_link("delete pet")
          click_link("delete pet")
        end

        expect(page).to_not have_xpath("//img[contains(@src, '#{pet_2.image}')]")
        expect(page).to_not have_content(pet_2.name)
        expect(page).to_not have_content(pet_2.approximate_age)
        expect(page).to_not have_content(pet_2.sex)
        expect(page).to_not have_content(pet_2.shelter.name)
      end
    end

    describe "user story 18" do
      it "I can see the pet's show page by clicking it's name" do
        shelter_1 = Shelter.create(name: "Colorado Cares", address: "867 magnolia st", city: "Lakewood", state: "CO", zip: "80022")
        pet_1 = shelter_1.pets.create(image: "https://dogtime.com/assets/uploads/gallery/austalian-shepherd-dog-breed-pictures/10-threequarters.jpg",
                          name: "Tony",
                          approximate_age: "2",
                          sex: "male",
                          description: "He is just adorable!")
        visit "/shelters/#{shelter_1.id}/pets"
        click_on "#{pet_1.name}"
        expect(current_path).to eq("/pets/#{pet_1.id}")
      end
    end

  end
end
