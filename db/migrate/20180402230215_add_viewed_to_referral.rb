class AddViewedToReferral < ActiveRecord::Migration[5.1]
  def change
    add_column :referrals, :viewed, :integer
  end
end
