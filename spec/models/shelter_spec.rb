require 'rails_helper'

RSpec.describe Shelter do
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should have_many :pets}
  end

end
