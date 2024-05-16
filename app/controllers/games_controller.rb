class GamesController < ApplicationController
  before_action :set_game, except: %w[new create]

  def new
    @game = Game.new
  end

  def create
    @game = Game.new creator: @player

    if @game.save
      redirect_to game_url(@game), notice: "Game was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @game.add_player(@player)
  end

  def start
    @game.start
    redirect_to @game
  end

  def toggle_cell
    @game.toggle_cell(params[:cell_index].to_i, @player)
    redirect_to @game
  end

  def update_player_color
    @game.update_player_color(@player, params[:color])
    redirect_to @game
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end
end
