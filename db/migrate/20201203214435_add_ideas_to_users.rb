class AddIdeasToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :ideas, :text
  end
end
