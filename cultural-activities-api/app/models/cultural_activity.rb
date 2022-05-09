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
    %i[title web_source date].each do |attr|
      value = params.with_indifferent_access[attr]
      if value.present?
        case attr
        when :web_source
          query = query.where(web_source_id: value.to_i)
        when :date
          start_date =  Date.strptime(value[0], "%Y-%m-%d")
          end_date =  Date.strptime(value[1], "%Y-%m-%d")
          query = query.where(":end_date >= start_date and end_date >= :start_date", start_date: start_date, end_date: end_date)
        when :title
          query = query.where("title ILIKE ?", "%#{sanitize_sql_like(value)}%")
        end
      end
    end
    query.order(:start_date)
  end
end