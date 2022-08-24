require 'rails_helper'

describe 'Items API' do
  describe 'GET /items' do
    it 'returns all items' do
      create_list(:item, 10)
      first_item = Item.first

      get '/api/v1/items'

      expect(response).to be_successful

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data).to be_a Hash
      expect(data).to have_key :data

      items = data[:data]

      expect(items).to be_an Array
      expect(items.count).to eq 10

      item_1 = items.first

      expect(item_1).to be_a Hash
      expect(item_1).to have_key :id
      expect(item_1[:id].to_i).to eq first_item.id

      expect(item_1).to have_key :type
      expect(item_1[:type]).to eq "item"

      expect(item_1).to have_key :attributes

      attributes = item_1[:attributes]

      expect(attributes).to be_a Hash
      expect(attributes).to have_key :name
      expect(attributes[:name]).to eq first_item.name

      expect(attributes).to have_key :description
      expect(attributes[:description]).to eq first_item.description

      expect(attributes).to have_key :unit_price
      expect(attributes[:unit_price]).to eq first_item.unit_price
    end
  end

  describe 'GET /items/:id' do
    it 'returns a single item if id found' do
      item = create(:item)

      get "/api/v1/items/#{item.id}"

      expect(response).to be_successful

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data).to be_a Hash
      expect(data).to have_key :data

      item_info = data[:data]

      expect(item_info).to be_a Hash
      expect(item_info).to have_key :id
      expect(item_info[:id].to_i).to eq item.id

      expect(item_info).to have_key :type
      expect(item_info[:type]).to eq "item"

      expect(item_info).to have_key :attributes

      attributes = item_info[:attributes]

      expect(attributes).to be_a Hash
      expect(attributes).to have_key :name
      expect(attributes[:name]).to eq item.name

      expect(attributes).to have_key :description
      expect(attributes[:description]).to eq item.description

      expect(attributes).to have_key :unit_price
      expect(attributes[:unit_price]).to eq item.unit_price
    end
  end
end
