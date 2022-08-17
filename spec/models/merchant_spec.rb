require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "Validations" do
    it 'should have a name' do
      merchant = create(:merchant)

      it { should validate_presence_of :name }
    end
  end
end
