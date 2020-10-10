require 'rails_helper'

RSpec.describe Pet do
  describe "validations" do
    it {should validate_presence_of :image}
  end
end 
