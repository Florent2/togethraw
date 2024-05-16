require "test_helper"

describe Game do
  describe "#reset" do
    before do
      @game = Game.create!
      %w[p1 p2 p3 p4].each { |p| @game.add_player p }
    end

    it "resets the cells" do
      @game.toggle_cell(0, "p1")
      @game.reset
      refute @game.cells[0]
    end

    it "picks a new word" do
      word = @game.word
      @game.reset
      refute_equal word, @game.word
    end

    it "sets new guessers and players" do
      @game.reset
      assert_equal %w[p3 p4], @game.drawers.sort
      assert_equal %w[p1 p2], @game.guessers.sort
    end
  end
end
