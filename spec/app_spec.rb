require '../app'

require_relative '../exceptions/controller_not_exist'

RSpec.describe App do

  describe '.find' do
    before do
      @app = App.new
      @app.create_trie
    end

    context 'if method exist' do
      it { expect( @app.find('user/1') ).to eq('1') }
    end

    context 'if method not exist' do
      it { expect{ @app.find('player/1') }.to raise_error(ControllerNotExist) }
    end
  end
end
