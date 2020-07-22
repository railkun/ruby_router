require "rack/test"

require_relative '../app'

describe App do
  include Rack::Test::Methods

  let(:app) { App.new }
  let(:id)  { 1 }
  let(:username) { 'Alex' }
  let(:token) { JwtAuth.token(username) }

  context 'get to home page' do
    let(:response) { get '/' }

    it { expect(response.status).to eq 200 }
    it { expect(response.body).to include 'Home Sweet Home' }
  end


  context 'get to /players/:id' do
    let(:response) { get '/players/1' }

    it { expect(response.status).to eq 200 }
    it { expect(response.body).to include "Players id is #{id}" }
  end

  context 'get to /players' do
    let(:response) { get '/players' }

    it { expect{ response }.to raise_error(ActionNotExist) }
  end

  context 'get to /users' do
    let(:response) { get "/users" }

    it { expect{ response.body }.to raise_error(Error_401) }
  end

  context 'get to /users?token=invalid_token' do
    let(:response) { get "/users?token=invalid_token" }

    it { expect{ response.body }.to raise_error(Error_401) }
  end

  context 'get to /users/:id?token=token' do
    let(:response) { get "users/1?token=#{token}" }

    it { expect(response.status).to eq 200 }
    it { expect(response.body).to include 'User name: Alex' }
  end

  context 'get to /users?token=token' do
    let(:response) { get "/users?token=#{token}" }

    it { expect(response.status).to eq 200 }
    it { expect(response.body).to include 'This is all users:' }
  end

  context 'post to /users?token=token' do
    let(:response) { post "/users?token=#{token}" }

    it { expect(response.status).to eq 200 }
    it { expect(response.body).to include 'This is all users:' }
  end

  context 'get to /users/new?token=token' do
    let(:response) { get "/users/new?token=#{token}" }

    it { expect(response.status).to eq 200 }
    it { expect(response.body).to include 'User name:' }
  end

  context 'get to /users/:id/edit?token=token' do
    let(:response) { get "/users/1/edit?token=#{token}" }

    it { expect(response.status).to eq 200 }
    it { expect(response.body).to include "Edit user id:#{id}" }
  end

  context 'patch to /users/:id?token=token' do
    let(:response) { patch "/users/1?token=#{token}" }

    it { expect(response.status).to eq 200 }
    it { expect(response.body).to include "Update user id:#{id}" }
  end

  context 'delete to /users/:id?token=token' do
    let(:response) { delete "/users/1?token=#{token}" }

    it { expect(response.status).to eq 200 }
    it { expect(response.body).to include "Delete user id:#{id}" }
  end

  context 'get to /matches' do
    let(:response) { get '/matches' }

    it { expect{ response }.to raise_error(ControllerNotExist) }
  end
end
