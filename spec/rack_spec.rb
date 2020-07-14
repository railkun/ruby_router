require "rack/test"

require_relative '../app'

describe App do
  include Rack::Test::Methods

  let(:app) { App.new }
  let(:id)  { 1 }

  context 'get to /players/:id' do
    let(:response) { get '/players/1' }

    it { expect(response.status).to eq 200 }
    it { expect(response.body).to include "Players id is #{id}" }
  end

  context 'get to /players' do
    let(:response) { get '/players' }

    it { expect{ response }.to raise_error(ActionNotExist) }
  end

  context 'get to /users/:id' do
    let(:response) { get 'users/1' }

    it { expect(response.status).to eq 200 }
    it { expect(response.body).to include "User id is #{id}" }
  end

  context 'get to /users' do
    let(:response) { get '/users' }

    it { expect(response.status).to eq 200 }
    it { expect(response.body).to include 'All users' }
  end

  context 'post to /users' do
    let(:response) { post '/users' }

    it { expect(response.status).to eq 200 }
    it { expect(response.body).to include 'Create user' }
  end

  context 'get to /users/new' do
    let(:response) { get '/users/new' }

    it { expect(response.status).to eq 200 }
    it { expect(response.body).to include 'Form create new user' }
  end

  context 'get to /users/:id/edit' do
    let(:response) { get '/users/1/edit' }

    it { expect(response.status).to eq 200 }
    it { expect(response.body).to include "Edit user id:#{id}" }
  end

  context 'patch to /users/:id' do
    let(:response) { patch '/users/1' }

    it { expect(response.status).to eq 200 }
    it { expect(response.body).to include "Update user id:#{id}" }
  end

  context 'delete to /users/:id' do
    let(:response) { delete '/users/1' }

    it { expect(response.status).to eq 200 }
    it { expect(response.body).to include "Delete user id:#{id}" }
  end

  context 'get to /matches' do
    let(:response) { get '/matches' }

    it { expect{ response }.to raise_error(ControllerNotExist) }
  end
end
