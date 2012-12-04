class CreateSonOfAnnotizers < ActiveRecord::Migration
  def change
    create_table :son_of_annotizers do |t|
      t.string :name
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
