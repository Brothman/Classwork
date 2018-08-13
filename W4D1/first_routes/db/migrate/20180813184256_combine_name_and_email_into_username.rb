class CombineNameAndEmailIntoUsername < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :name
    remove_column :users, :email
    add_column :users, :username, :string, null: false
  end
end
