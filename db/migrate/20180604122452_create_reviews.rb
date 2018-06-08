class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.string :status
      t.text :content

      t.timestamps

	  t.index [:user_id,:book_id], unique: true
    end
  end
end
