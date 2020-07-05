require '../trie/trie'

require_relative '../exceptions/route_must_be_unique'
require_relative '../exceptions/route_not_exist'

RSpec.describe Trie do
  subject { described_class.new }

  describe '.add_route' do

    context 'if route add correct' do
      it { expect( subject.add_route('/player/:id/info') ).to eq('/player/:id/info') }
    end

    context 'route element must be unique' do
      it { expect{ subject.add_route('/player/:id/info/:id') }.to raise_error(RouteMustBeUnique) }
    end
  end

  describe '.add_node' do

    context 'add node' do
      let(:node) { Node.new('player') }

      it { expect( subject.add_node('id', node.children)).to eq(node.children[0]) }

      it { expect( subject.add_node('player', [])).eql?(node) }
    end

    context 'if value with :' do
      it { expect( subject.add_node(':id', []).type ).to eq(1) }
    end

    context 'if value without :' do
      it { expect( subject.add_node('id', []).type ).to eq(0) }
    end
  end

  describe '.find' do
    before do
      @trie = Trie.new
      @trie.add_route('/player/:id/info')
      @trie.add_route('/player/id/info')
    end

    context 'find route if route exist and type DYNAMIC' do
      it { expect( @trie.find('/player/1/info').route ).to eq('/player/:id/info') }

      it { expect( @trie.find('/player/1/info').dynamic_value ).to eq({':id' => '1'}) }
    end

    context 'find route if route exist and type STATIC' do
      it { expect( @trie.find('/player/id/info').route ).to eq('/player/id/info') }

      it { expect( @trie.find('/player/id/info').dynamic_value ).to eq({}) }
    end

    context 'find route if route not exist' do
      it { expect{ @trie.find('/player/:id') }.to raise_error(RouteNotExist) }
    end

    context 'find route if route not exist' do
      it { expect{ @trie.find('/team/player/:id') }.to raise_error(RouteNotExist) }
    end
  end
end
