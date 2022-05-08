class CulturalActivity < ApplicationRecord
  belongs_to :web_source

  validates_presence_of %i[title]
  validates_associated :web_source

  scope :ordered_activities_by_start_date, -> { where("start_date >= ? OR end_date >= ?", Date.today, Date.today).order(:start_date) }
  scope :scheduled_activities, -> { where("start_date >= ? OR end_date >= ?", Date.today, Date.today)}

  def self.delete_scheduled_activities
    scheduled_activities.destroy_all
  end

  def self.search(params)
    query = all
    %i[title start_date web_source].each do |attr|
      value = params.with_indifferent_access[attr]
      if value.present?
        case attr
        when :web_source
          query = query.where(web_source_id: value.to_i)
        when :start_date
          date = Date.strptime(value, "")
          query = query.where("start_date >= ? OR end_date >= ?", date, date)
        when :title
          query = query.where("title ILIKE ?", "%#{sanitize_sql_like(value)}%")
        end
      end
    end
    query.order(:start_date)
  end
end