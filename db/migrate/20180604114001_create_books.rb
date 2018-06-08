class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :subtitle
      t.string :publisher
      t.datetime :publish_date
      t.string :isbn
      t.string :url
      t.string :image_url
      t.text :description

      t.timestamps
    end
  end
end
