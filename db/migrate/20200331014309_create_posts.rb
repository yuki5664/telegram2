class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.text :caption, null: false, lenght: 1000
      t.timestamps
    end
  end
end
