require '../trie/trie'

RSpec.describe Trie do
  subject { described_class.new }

  describe '.add_route' do

    let(:player_info) { '/player/:id/info' }

    context 'if route add correct' do
      it { expect( subject.add_route(player_info) ).eql?('/player/:id/info') }
    end
  end

  describe '.add_node' do

    context 'if value with :' do
      it { expect( subject.add_node(':id', []).type ).eql?('dynamic') }
    end

    context 'if value without :' do
      it { expect( subject.add_node('id', []).type ).eql?('static') }
    end
  end
end
