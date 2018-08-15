class AddColumnAndIndexToCatRentalRequestForUserId < ActiveRecord::Migration[5.2]
  def change
    CatRentalRequest.destroy_all
    add_column :cat_rental_requests, :user_id, :integer, null: false
    add_index :cat_rental_requests, :user_id
  end
end
