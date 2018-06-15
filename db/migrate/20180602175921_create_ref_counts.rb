class CreateRefCounts < ActiveRecord::Migration[5.1]
  def change
    create_table :ref_counts do |t|
      t.string :wp_id
      t.integer :amount

      t.timestamps
    end
  end
end
