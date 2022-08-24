require 'rails_helper'

describe "Merchants API" do
  describe "get /merchants" do
    it 'returns all merchants' do
      create_list(:merchant, 10)
      merchant1 = Merchant.first

      get '/api/v1/merchants'

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants).to be_a Hash
      expect(merchants).to have_key :data
      expect(merchants[:data]).to be_an Array
      expect(merchants[:data].count).to eq 10
      first_merchant = merchants[:data].first

      expect(first_merchant).to be_a Hash

      expect(first_merchant).to have_key :id
      expect(first_merchant[:id].to_i).to eq merchant1.id

      expect(first_merchant).to have_key :type
      expect(first_merchant[:type]).to eq "merchant"

      expect(first_merchant).to have_key :attributes

      expect(first_merchant).to_not have_key :name

      expect(first_merchant[:attributes]).to be_a Hash
      expect(first_merchant[:attributes]).to have_key :name
      expect(first_merchant[:attributes][:name]).to eq merchant1.name
    end
  end

  describe 'GET /merchants/:id' do
    it 'returns single merchant' do
      merchants = create_list(:merchant, 6)
      merchant1 = Merchant.first

      get "/api/v1/merchants/#{merchant1.id}"

      expect(response).to be_successful

      merchant_data = JSON.parse(response.body, symbolize_names: true)

      expect(merchant_data).to be_a Hash

      merchant = merchant_data[:data]

      expect(merchant).to have_key :id
      expect(merchant[:id].to_i).to eq merchant1.id

      expect(merchant).to have_key :type
      expect(merchant[:type]).to eq "merchant"

      expect(merchant).to have_key :attributes

      expect(merchant).to_not have_key :name

      expect(merchant[:attributes]).to be_a Hash
      expect(merchant[:attributes]).to have_key :name
      expect(merchant[:attributes][:name]).to eq merchant1.name
    end

    it 'returns 404 if no merchant id matches' do
      get "/api/v1/merchants/1"

      expect(response).to_not be_successful
      expect(response).to have_http_status 404
    end
  end
end
