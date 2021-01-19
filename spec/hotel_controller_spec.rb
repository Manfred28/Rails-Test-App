require 'rails_helper'
require 'spec_helper'

RSpec.describe HotelController, type: :controller do
  before(:each) do
    @hotel1 = Hotel.create!(destination_id: 1, name: 'test1')
    @hotel2 = Hotel.create!(destination_id: 2, name: 'test2')
  end

  it 'returns hotels filtered by id' do
    get :index, params: { id: @hotel1.id }, format: :json
    body = JSON.parse(response.body)
    expect(body.pluck('id')).to eq [@hotel1.id]
  end

  it 'returns hotels filtered by destination_id' do
    get :index, params: { destination_id: @hotel1.destination_id }, format: :json
    body = JSON.parse(response.body)
    expect(body.pluck('id')).to eq [@hotel1.id]
  end
end
