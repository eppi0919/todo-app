class CreateBoards < ActiveRecord::Migration[6.0]
  def change
    create_table :boards do |t|
      t.string :name
      t.text :description
      t.references :user, null: false
      t.timestamps
    end
  end
end
