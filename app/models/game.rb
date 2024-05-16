class Game < ApplicationRecord
  broadcasts_refreshes

  CELLS_NB = 100
  DRAWERS_NB = 2
  WORDS = %w[Sun Star Heart Fish Tree House Car Boat Bird Hat Key Flag Arrow Smile Flower Mountain Ball Cloud Cake Chair Bridge Train]
  #WORDS = %w[Soleil Étoile Cœur Poisson Arbre Maison Voiture Bateau Oiseau Chapeau Clé Drapeau Flèche Sourire Fleurs Montagne Arc Papillon Ballon Échelle Nuage Gâteau Chaise Pont Train Bonhomme Lunettes]

  def start
    setup_cells
    pick_word
    pick_drawers_and_guessers
    self.move_players = []
    self.started = true
    save!
  end

  def add_player(player)
    return if drawers.include?(player) || guessers.include?(player)

    if drawers.size < DRAWERS_NB
      drawers << player
      self.current_drawer = player if drawers.size == 1
    else
      guessers << player
    end
    save!
  end

  def can_toggle_cell?(cell_index, player)
    started? && player == current_drawer
  end

  def toggle_cell(cell_index, player)
    return unless started?

    cells[cell_index] = player_colors[player] || "black"
    move_players << player
    self.current_drawer = next_drawer
    save!
  end

  def is_drawer?(player)
    started? && drawers.include?(player)
  end

  def color(player)
    player_colors[player] || "black"
  end

  def update_player_color(player, color)
    update! player_colors: player_colors.merge({player => color})
  end

  private

  def pick_drawers_and_guessers
    players = guessers.shuffle + drawers
    self.drawers, self.guessers = players.shift(DRAWERS_NB), players
    self.current_drawer = drawers.first
  end

  def pick_word
    self.word = (WORDS - [word]).sample
  end

  def setup_cells
    self.cells = Array.new(CELLS_NB, "white")
  end

  def next_drawer
    if move_players.last(3) == [current_drawer, current_drawer, current_drawer]
      current_drawer_index = drawers.index(current_drawer)
      next_drawer_index = current_drawer_index.next % drawers.size
      drawers[next_drawer_index]
    else
      current_drawer
    end
  end
end
