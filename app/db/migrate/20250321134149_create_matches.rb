class CreateMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :matches do |t|
      t.references :team1, foreign_key: { to_table: :teams }
      t.references :team2, foreign_key: { to_table: :teams }
      t.integer :team1_score
      t.integer :team2_score
      t.references :tournament, foreign_key: true

      t.timestamps
    end
  end
end
