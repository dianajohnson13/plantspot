class AddBioToUserProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :mini_bio, :string
  end
end
