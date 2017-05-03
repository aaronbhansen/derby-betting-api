class CreateRaceDates < ActiveRecord::Migration[5.1]
  def change
    create_table :race_dates do |t|
      t.date       :date,      null: false
      t.integer    :races,     null: false
      t.references :track,     null: false
      t.timestamps
    end

    add_foreign_key :race_dates, :tracks, name: 'fk_race_dates_track'
  end
end
