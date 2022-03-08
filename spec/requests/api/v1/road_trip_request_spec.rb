require 'rails_helper'
RSpec.describe 'session request' do
  before (:each) do
    @user = User.create(email: "gseth26@gmail.com", password: "password", password_confirmation: "password" )
  end
  it 'returns json response for a road trip when a valid API key is given', :vcr do
    body = {
        "origin": "Denver,CO",
        "destination": "Pueblo,CO",
        "api_key": "#{@user.auth_token}"
    }
    headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
    post '/api/v1/road_trip', headers: headers, params: JSON.generate(body)

    road_trip = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(200)
    expect(road_trip).to have_key(:data)
    expect(road_trip[:data]).to have_key(:id)
    expect(road_trip[:data]).to have_key(:type)
    expect(road_trip[:data]).to have_key(:attributes)
    expect(road_trip[:data][:type]).to eq("roadtrip")
    expect(road_trip[:data][:attributes]).to have_key(:start_city)
    expect(road_trip[:data][:attributes]).to have_key(:end_city)
    expect(road_trip[:data][:attributes]).to have_key(:travel_time)
    expect(road_trip[:data][:attributes]).to have_key(:weather_at_eta)
  end

  it 'returns json response for incorrect API key', :vcr do
    body = {
        "origin": "Denver,CO",
        "destination": "Pueblo,CO",
        "api_key": "1234"
    }
    headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
    post '/api/v1/road_trip', headers: headers, params: JSON.generate(body)

    road_trip = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(200)
    expect(road_trip[:data]).to have_key(:message)
    expect(road_trip[:data][:message]).to eq("Invalid API Key")
  end

  it 'returns travel time impossible when route cannot be mapped', :vcr do
    body = {
        "origin": "Denver,CO",
        "destination": "Tokyo",
        "api_key": "#{@user.auth_token}"
    }
    headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
    post '/api/v1/road_trip', headers: headers, params: JSON.generate(body)

    road_trip = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(200)
    expect(road_trip).to have_key(:data)
    expect(road_trip[:data]).to have_key(:id)
    expect(road_trip[:data]).to have_key(:type)
    expect(road_trip[:data]).to have_key(:attributes)
    expect(road_trip[:data][:type]).to eq("roadtrip")
    expect(road_trip[:data][:attributes]).to have_key(:start_city)
    expect(road_trip[:data][:attributes]).to have_key(:end_city)
    expect(road_trip[:data][:attributes]).to have_key(:travel_time)
    expect(road_trip[:data][:attributes][:travel_time]).to eq("Impossible")
    expect(road_trip[:data][:attributes]).to have_key(:weather_at_eta)
  end
end
