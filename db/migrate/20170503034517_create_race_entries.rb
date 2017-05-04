class CreateRaceEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :race_entries do |t|
      t.references :race,          null: false
      t.integer    :post_position, null: false
      t.text       :program_number
      t.boolean    :scratched,     null: false
      t.text       :jockey
      t.text       :horse_name
      t.text       :horse_color
      t.integer    :horse_birth_year
      t.integer    :morning_odds_numerator
      t.integer    :morning_odds_denominator
      t.integer    :current_odds_numerator
      t.integer    :current_odds_denominator
      t.integer    :finish_position
      t.decimal    :win_payoff
      t.decimal    :place_payoff
      t.decimal    :show_payoff
      t.timestamps
    end

    add_foreign_key :race_entries, :races, name: 'fk_race_entries_race'
  end
end
