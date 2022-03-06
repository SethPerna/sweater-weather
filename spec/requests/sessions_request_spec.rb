require 'rails_helper'
RSpec.describe 'session request' do
  it 'returns json' do
    data = {
      "email": "gseth26@gmail.com",
      "password": "password",
      "password_confirmation": "password"
    }
    headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
    post '/api/v1/users', headers: headers, params: JSON.generate(data)
    user_register = JSON.parse(response.body, symbolize_names: true)

    data_login = {
      "email": "gseth26@gmail.com",
      "password": "password",
    }
    headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
    post '/api/v1/sessions', headers: headers, params: JSON.generate(data_login)
    user = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(user[:data]).to have_key(:type)
    expect(user[:data]).to have_key(:id)
    expect(user[:data]).to have_key(:attributes)
    expect(user[:data][:attributes]).to have_key(:email)
    expect(user[:data][:attributes]).to have_key(:api_key)
    expect(user[:data][:attributes]).to_not have_key(:password)
    expect(user[:data][:attributes]).to_not have_key(:password_confirmation)
  end

  it 'returns invalid credentials when password does not match' do
    data = {
      "email": "gseth26@gmail.com",
      "password": "password",
      "password_confirmation": "password"
    }
    headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
    post '/api/v1/users', headers: headers, params: JSON.generate(data)

    data_login = {
      "email": "gseth26@gmail.com",
      "password": "pass",
    }
    headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
    post '/api/v1/sessions', headers: headers, params: JSON.generate(data_login)
    user = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(200)
    expect(user).to have_key(:data)
    expect(user[:data]).to have_key(:message)
    expect(user[:data][:message]).to eq("Incorrect Email/Password")
  end

  it 'returns invalid credentials when email does not match' do
    data = {
      "email": "gseth26@gmail.com",
      "password": "password",
      "password_confirmation": "password"
    }
    headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
    post '/api/v1/users', headers: headers, params: JSON.generate(data)

    data_login = {
      "email": "gseth26gmail.com",
      "password": "password",
    }
    headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
    post '/api/v1/sessions', headers: headers, params: JSON.generate(data_login)
    user = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(200)
    expect(user).to have_key(:data)
    expect(user[:data]).to have_key(:message)
    expect(user[:data][:message]).to eq("Incorrect Email/Password")
  end

  it 'returns invalid credentials when email and password do not match' do
    data = {
      "email": "gseth26@gmail.com",
      "password": "password",
      "password_confirmation": "password"
    }
    headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
    post '/api/v1/users', headers: headers, params: JSON.generate(data)

    data_login = {
      "email": "gth26gmail.com",
      "password": "passwrd",
    }
    headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
    post '/api/v1/sessions', headers: headers, params: JSON.generate(data_login)
    user = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(200)
    expect(user).to have_key(:data)
    expect(user[:data]).to have_key(:message)
    expect(user[:data][:message]).to eq("Incorrect Email/Password")
  end
end
