class AddTypeToReferrals < ActiveRecord::Migration[5.1]
  def change
    add_column :referrals, :type, :integer
  end
end
