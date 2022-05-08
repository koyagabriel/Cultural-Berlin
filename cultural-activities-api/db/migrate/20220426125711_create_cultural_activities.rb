class CreateCulturalActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :cultural_activities do |t|
      t.string :title, null: false
      t.date :start_date
      t.date :end_date
      t.time :start_time
      t.time :end_time
      t.string :description
      t.string :detail_url
      t.string :image_url
      t.references :web_source

      t.timestamps
    end
  end
end
