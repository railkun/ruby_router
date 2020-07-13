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

    it { expect(response.body).to include 'All users' }
  end

  context 'get to /matches' do
    let(:response) { get '/matches' }

    it { expect{ response }.to raise_error(ControllerNotExist) }
  end
end
