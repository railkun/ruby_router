require 'pry'

RSpec.describe Trie do
  describe '.parse' do

    subject { described_class.new }

    let(:player_info) do
      { player_info: {
          id: 1
      }}
    end

    context 'if correct id' do
      it { expect( subject.parse('/player/1/info') ).eql?(player_info) }
    end

    context 'if wrong id' do
      it { expect { subject.parse('/player/a/info') }.to raise_error(UndefinedId) }
    end
  end
end
