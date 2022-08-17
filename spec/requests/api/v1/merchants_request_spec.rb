require 'rails_helper'

describe "Merchants API" do
  describe "get /merchants" do
    it 'returns all merchants' do
      create_list(:mechants, 10)
      merchant1 = Merchant.first

      get '/api/v1/merchants'

      expect(response).to be_successful

      response = JSON.parse(response.body)
      expect(response).to be_a Hash
      expect(response).to have_key "data"
      expect(response["data"]).to be_an Array
      expect(response["data"].count).to eq 10

      first_merchant = response["data"].first

      expect(first_merchant).to be_a Hash

      expect(first_merchant).to have_key "id"
      expect(first_merchant["id"]).to eq merchant1.id

      expect(first_merchant).to have_key "type"
      expect(first_merchant["id"]).to eq "merchant"

      expect(first_merchant).to have_key "attributes"

      expect(first_merchant).to_not have_key "name"

      expect(first_merchant["attributes"]).to be_a Hash
      expect(first_merchant["attributes"]).to have_key "name"
      expect(first_merchant["attributes"]["name"]).to eq merchant1.name
    end
  end
end
