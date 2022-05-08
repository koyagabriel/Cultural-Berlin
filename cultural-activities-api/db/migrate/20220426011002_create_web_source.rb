class CreateWebSource < ActiveRecord::Migration[5.0]
  def change
    create_table :web_sources do |t|
      t.string :name, null: false
      t.string :url, null: false
      t.string :slug, null: false

      t.timestamps
    end

    add_index :web_sources, :name, unique: true
  end
end
