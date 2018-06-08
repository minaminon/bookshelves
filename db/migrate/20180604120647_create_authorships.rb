class CreateAuthorships < ActiveRecord::Migration[5.0]
  def change
    create_table :authorships do |t|
      t.references :book, foreign_key: true
      t.references :author, foreign_key: true

      t.timestamps

	  t.index [:book_id,:author_id], unique: true
    end
  end
end
