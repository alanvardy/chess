require 'spec_helper'
require 'board'

describe Board do
  before do
    allow($stdout).to receive(:write)
  end

  let(:board) { board ||= Board.new }

  describe 'when initialized' do
    context 'it first' do
      it 'creates an error array' do
        expect(board.errors).to be_an_instance_of(Array)
      end
    end
    it 'creates the board' do
      expect(board.board).to eq(
        [[' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']])
    end
  end

  describe '#add_pieces' do
    it 'creates pieces' do
      board.add_pieces
      expect(board.board[0][0].is_a?(Piece)).to be(true)
    end
    it 'leaves empty spaces in the middle' do
      expect(board.board[2][2]).to eq(" ")
    end
  end

  describe '#display' do
    it 'calls clear_screen' do
      expect(board).to receive(:clear_screen).once
      board.display
    end

    it 'calls horizontal_lines' do
      expect(board).to receive(:horizontal_line).at_least(:twice)
      board.display
    end

    it 'calls print_errors' do
      expect(board).to receive(:print_errors).once
      board.display
    end
  end

  describe '#select_square' do
    before do
      board.instance_variable_set(:@player_turn, Player.new('Test', 'black'))
      board.add_pieces
    end
    it 'calls input_coordinates' do
      expect(board).to receive(:input_coordinates).and_return([0,0])
      board.select_square
    end
  end

  describe '#input_coordinates' do
    pending 'todo'
  end

  describe '#convert' do
    context 'when given valid input' do
      it 'returns 2 valid integers' do
        expect(board.convert('b3')).to eq([2, 1])
      end
    end
  end

  describe '#start' do
    it 'calls #add_pieces' do
      expect(board).to receive(:add_pieces)
      allow(board).to receive(:create_players)
      allow(board).to receive(:game)
      board.start
    end
    it 'calls #create_players' do
      allow(board).to receive(:add_pieces)
      expect(board).to receive(:create_players)
      allow(board).to receive(:game)
      board.start
    end
    it 'calls #game' do
      allow(board).to receive(:add_pieces)
      allow(board).to receive(:create_players)
      expect(board).to receive(:game)
      board.start
    end
  end

  describe '#create_players' do
    before do
      allow(board).to receive(:input).and_return("Test")
      board.create_players
    end
    it 'creates white player' do
      expect(board.white_player.is_a?(Player)).to be(true)
    end
    it 'creates white player' do
      expect(board.black_player.is_a?(Player)).to be(true)
    end
  end

  describe '#game' do
    context 'until won? is false' do
      it 'loops twice' do
        expect(board).to receive(:won?).twice.and_return(false, true)
        allow(board).to receive(:display)
        allow(board).to receive(:select_square)
        allow(board).to receive(:clear_screen)
        allow(board).to receive(:move)
        allow(board).to receive(:change_player)
        allow(board).to receive(:declare_winner)
        board.game
      end
    end
  end

  describe '#won?' do
    context 'when both players have kings' do
      it 'returns false' do
        allow(board).to receive(:has_king?).and_return(true)
        expect(board.won?).to be(false)
      end
    end
    context 'when one player has no king' do
      it 'returns true' do
        allow(board).to receive(:has_king?).and_return(false, true)
        expect(board.won?).to be(true)
      end
    end
  end

  describe '#has_king?' do
    context 'when no king on board' do
      it 'returns false' do
        expect(board.has_king?("white")).to be(false)
      end
    end
    context 'when a matching king on board' do
      it 'returns true' do
        board.add_pieces
        expect(board.has_king?("white")).to be(true)
      end
    end
  end

  describe '#declare_winner' do
    it 'calls has_king? twice' do
      board.instance_variable_set(:@white_player, Player.new("Test", "Purple"))
      board.instance_variable_set(:@black_player, Player.new("Test", "Purple"))
      expect(board).to receive(:has_king?).twice
      board.declare_winner
    end
  end

  describe '#change_player' do
    context 'when white players turn' do
      it 'sets turn to black players' do
        board.instance_variable_set(:@player_turn, "1")
        board.instance_variable_set(:@white_player, "1")
        board.instance_variable_set(:@black_player, "2")
        board.change_player
        expect(board.player_turn).to eq("2")
      end
    end
    context 'when not white players turn' do
      it 'sets turn to white players' do
        board.instance_variable_set(:@player_turn, "3")
        board.instance_variable_set(:@white_player, "1")
        board.instance_variable_set(:@black_player, "2")
        board.change_player
        expect(board.player_turn).to eq("1")
      end
    end
  end

  describe '#move' do
    context 'when @selected_piece is nil' do
      before do
        allow(board).to receive(:select_square)
        board.instance_variable_set(:@selected_piece, nil)
        board.move
      end

      it 'doesn\'t call input coordinates' do
        expect(board).to_not receive(:input_coordinates)
      end
    end

    context 'when a piece is selected' do
      it 'calls input_coordinates' do
        expect(board).to receive(:input_coordinates)
        board.instance_variable_set(:@selected_piece, Rook.new("black", [0,0]))
        allow(board).to receive(:valid_attack?).and_return(false)
        allow(board).to receive(:opposing_piece?).and_return(false)
        allow(board).to receive(:valid_move?).and_return(false)
        board.move
      end

      context 'when attack is valid' do
        it 'calls attack_piece' do
          board.instance_variable_set(:@selected_piece, Rook.new("black", [0,0]))
          allow(board).to receive(:input_coordinates)
          allow(board).to receive(:valid_move?).and_return(false)
          allow(board).to receive(:valid_attack?).and_return(true)
          allow(board).to receive(:opposing_piece?).and_return(true)
          expect(board).to receive(:attack_piece)
          board.move
        end
      end

      context 'if move is valid' do
        it 'calls move_piece' do
          board.instance_variable_set(:@selected_piece, Rook.new("black", [0,0]))
          allow(board).to receive(:input_coordinates)
          allow(board).to receive(:valid_move?).and_return(true)
          allow(board).to receive(:valid_attack?).and_return(false)
          expect(board).to receive(:move_piece)
          board.move
        end
      end
      context 'if move is not valid' do
        it 'calls clear_selection' do
          board.instance_variable_set(:@selected_piece, Rook.new("black", [0,0]))
          allow(board).to receive(:input_coordinates)
          allow(board).to receive(:valid_move?).and_return(false)
          allow(board).to receive(:valid_attack?).and_return(false)
          expect(board).to receive(:clear_selection)
          board.move
        end
      end
    end
  end

  describe '#opposing_piece?' do
    before do
      board.add_pieces
      board.instance_variable_set(:@selected_piece, board.board[0][0])
    end
    context 'when not a piece' do
      it 'returns false' do
        expect(board.opposing_piece?(2, 2)).to be(false)
      end
    end
    context 'when same color as player' do
      it 'returns false' do
        expect(board.opposing_piece?(0, 1)).to be(false)
      end
    end
    context 'when a piece of another color' do
      it 'returns true' do
        expect(board.opposing_piece?(7, 7)).to be(true)
      end
    end
  end

  describe '#clear_selection' do
    before do
      board.instance_variable_set(:@selected_piece, "test")
      board.instance_variable_set(:@selected_coordinates, "test")
      board.clear_selection
    end
    it 'clears @selected_piece' do
      expect(board.selected_piece).to be_nil
    end
    it 'clears @selected_coordinates' do
      expect(board.selected_coordinates).to be_nil
    end

  end

  describe '#attack_piece' do
    pending 'todo'
  end

  describe '#move_piece' do
    before do
      board.instance_variable_set(:@selected_piece, Pawn.new("White", [4, 5]))
      board.instance_variable_set(:@selected_coordinates, [4, 5])
      board.move_piece(1, 2)
    end
    it 'moves the piece to the new location' do
      expect(board.board[1][2].color).to eql("White")
    end

    it 'sets the location in the piece' do
      expect(board.board[1][2].location).to eql([1, 2])
    end

    it 'sets the old location back to blank' do
      expect(board.board[4][5]).to eql(" ")
    end

    it 'calls clear_selection' do
      board.instance_variable_set(:@selected_piece, Pawn.new("White", [4, 5]))
      board.instance_variable_set(:@selected_coordinates, [4, 5])
      expect(board).to receive(:clear_selection)
      board.move_piece(1, 2)
    end
  end

  describe '#valid_attack?' do
    before do
      board.add_pieces
      board.instance_variable_set(:@selected_piece, board.board[0][0])
    end
    context 'if in list of attacks' do
      it 'returns true' do
        expect(board.valid_attack?(7, 0)).to be(true)
      end
    end
    context 'if not in list of attacks' do
      it 'returns false' do
        expect(board.valid_attack?(7, 1)).to be(false)
      end
      it 'adds an error' do
        board.valid_attack?(7, 1)
        expect(board.errors.length).to eq(1)
      end
    end
  end

  describe '#valid_move?' do
    before do
      board.instance_variable_set(:@selected_piece, Queen.new("White", [0, 0]))
    end
    context 'when move is valid' do
      it 'returns true' do
        expect(board.valid_move?(2, 0)).to be(true)
      end
    end
    context 'when move is not valid' do
      it 'returns false' do
        expect(board.valid_move?(2, 1)).to be(false)
      end
    end
    context 'when destination selected is the same color piece' do
      before do
        board.add_pieces
        board.instance_variable_set(:@selected_piece, board.board[0][0])
      end
      it 'returns false' do
        expect(board.valid_move?(0, 1)).to be(false)
      end
      it 'adds an error' do
        board.valid_move?(0, 1)
        expect(board.errors.length).to eq(1)
      end
    end
  end
end
