class AddPromoCodeToMembers < ActiveRecord::Migration[5.1]
  def change
    add_column :members, :promo_code, :string
  end
end
