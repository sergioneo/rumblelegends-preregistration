class CreateFreeTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :free_tickets do |t|
      t.string :owner_wp_id
      t.boolean :viewed
      t.integer :category

      t.timestamps
    end
  end
end
