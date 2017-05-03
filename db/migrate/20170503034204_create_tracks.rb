class CreateTracks < ActiveRecord::Migration[5.1]
  def change
    create_table :tracks do |t|
      t.text    :name,   null: false
      t.text    :timezone
      t.text    :country
      t.text    :horse_type
      t.timestamps
    end
  end
end
