class FixRememberDigestTypo < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :rememeber_digest, :remember_digest
  end
end
