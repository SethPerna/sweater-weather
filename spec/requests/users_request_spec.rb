require 'rails_helper'
RSpec.describe 'users request' do
  it 'returns json' do
    params = {
      "email": "gseth26@gmail.com",
      "password": "password"
      "password_confirmation"
    }
    headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
    post '/api/v1/users', headers: headers, params: { params }
    background = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(response.status).to eq(200)
  end
end
