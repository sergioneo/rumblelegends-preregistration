class DropTypeFromReferral < ActiveRecord::Migration[5.1]
  def change
  	remove_column :referrals, :type
  	
  end
end
