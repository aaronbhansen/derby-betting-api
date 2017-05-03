class CreateRaces < ActiveRecord::Migration[5.1]
  def change
    create_table :races do |t|
      t.references :race_date,   null: false
      t.references :track,       null: false
      t.integer    :number,      null: false
      t.text       :name
      t.text       :distance
      t.datetime   :last_updated_on
      t.datetime   :post_time
      t.text       :surface
      t.text       :track_condition
      t.text       :wager_type
      t.decimal    :exacta_base_bet_amount
      t.decimal    :exacta_payoff_amount
      t.decimal    :trifecta_base_bet_amount
      t.decimal    :trifecta_payoff_amount
      t.timestamps
    end

    add_foreign_key :races, :race_dates, name: 'fk_races_race_date'
    add_foreign_key :races, :tracks, name: 'fk_races_track'
  end
end
