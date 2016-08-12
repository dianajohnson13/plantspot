class AddRememberDigestToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :rememeber_digest, :string
  end
end
