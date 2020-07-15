require_relative '../app'

RSpec.describe App do

  describe '.find' do
    let(:id) { 1 }

    before do
      @app = App.new
    end

    context 'if class exist but method not exist' do
      it { expect{ @app.find('GET:/players') }.to raise_error(ActionNotExist) }
    end

    context 'if method not exist' do
      it { expect( @app.find("GET:/players/#{id}") ).to eq("Players id is #{id}") }
    end

    context 'if class and method exist' do
      it { expect( @app.find('GET:/users') ).to include 'This is all users:' }
    end

    context 'if class and method exist' do
      it { expect( @app.find("GET:/users/#{id}") ).to include 'User name: Alex' }
    end

    context 'if class and method exist' do
      it { expect{ @app.find('GET:/matches') }.to raise_error(ControllerNotExist) }
    end
  end
end
