class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books, id: false, primary_key: :B_id do |t|
      t.integer :B_id, primary_key:true
      t.string :B_title
      t.string :Author
      t.string :Publisher
      t.date :Year

      t.timestamps
    end
  end
end
