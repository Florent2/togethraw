class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.string :cells, array: true, default: []
      t.string :drawers, array: true, default: []
      t.string :guessers, array: true, default: []
      t.string :word
      t.string :current_drawer
      t.boolean :started, default: false, null: false
      t.string :creator, null: false
      t.string :move_players, array: true, default: []
      t.json :player_colors, :json, default: {}

      t.timestamps
    end
  end
end
