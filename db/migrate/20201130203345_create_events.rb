class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :code
      t.integer :admin_id
      t.date :start
      t.date :end
      t.integer :max_price
      t.text :notes
    end
  end
end
