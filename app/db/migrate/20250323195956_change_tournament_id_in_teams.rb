class ChangeTournamentIdInTeams < ActiveRecord::Migration[8.0]
  def change
    change_column_null :teams, :tournament_id, true
  end
end
