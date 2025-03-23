class AddTournamentToTeams < ActiveRecord::Migration[8.0]
  def change
    add_reference :teams, :tournament, null: false, foreign_key: true
  end
end
