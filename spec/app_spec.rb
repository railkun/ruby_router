require_relative '../app'
require_relative '../exceptions/controller_not_exist'

RSpec.describe App do

  describe '.find' do
    let(:routes) do {
      'players#index' => '/players',
      'players#show'  => '/players/:id',
      'users#index'   => '/users',
      'users#show'    => '/users/:id',
      'home#index'    => '/',
      'matches#index' => '/matches'
      }
    end

    let(:id) { 1 }

    before do
      @app = App.new(routes)
    end

    context 'if class exist but method not exist' do
      it { expect{ @app.find('/players') }.to raise_error(ActionNotExist) }
    end

    context 'if method not exist' do
      it { expect( @app.find("players/#{id}") ).to eq("Players id is #{id}") }
    end

    context 'if class and method exist' do
      it { expect( @app.find('/users') ).to eq('All users') }
    end

    context 'if class and method exist' do
      it { expect( @app.find("/users/#{id}") ).to eq("User id is #{id}") }
    end

    context 'if class and method exist' do
      it { expect{ @app.find('/matches') }.to raise_error(NameError) }
    end
  end
end
