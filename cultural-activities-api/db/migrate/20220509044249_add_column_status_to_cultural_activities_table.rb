class AddColumnStatusToCulturalActivitiesTable < ActiveRecord::Migration[5.0]
  def change
    add_column :cultural_activities, :status, :integer, default: 1
  end
end
