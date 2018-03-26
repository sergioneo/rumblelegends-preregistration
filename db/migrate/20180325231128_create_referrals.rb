class CreateReferrals < ActiveRecord::Migration[5.1]
  def change
    create_table :referrals do |t|
      t.string :owner_wp_id
      t.string :referred_wp_id

      t.timestamps
    end
  end
end
