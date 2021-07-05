require 'rails_helper'

RSpec.describe UserBook, type: :model do
  describe "Validations status" do 
    it 'validates uniqueness status' do
      expect(UserBook.validates_uniqueness_of(:status))
    end
  end


  
end
