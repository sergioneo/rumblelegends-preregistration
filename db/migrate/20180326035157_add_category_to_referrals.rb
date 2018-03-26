class AddCategoryToReferrals < ActiveRecord::Migration[5.1]
  def change
    add_column :referrals, :category, :integer
  end
end
