require 'spec_helper'
require 'players'

describe Player do
  describe 'when initialized' do
    it 'has a name' do
      player = Player.new('test', 'purple')
      expect(player.name).to eq('test')
    end
    it 'has a color' do
      player = Player.new('test', 'purple')
      expect(player.color).to eq('purple')
    end
  end
end
