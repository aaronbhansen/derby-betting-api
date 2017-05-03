class CreatePlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :players do |t|
      t.text    :name,  null: false
      t.text    :motto, null: false
      t.timestamps
    end
  end
end
