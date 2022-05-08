class WebSource < ApplicationRecord
  has_many :cultural_activities

  validates_presence_of %i[name url slug]
  validates_uniqueness_of %i[name url slug]

  def self.fetch_and_persist_activities
    mapper_path = Rails.root.join("data/mapper.json")
    mapper = JSON.load(File.open(mapper_path))

    ActiveRecord::Base.transaction do
      all.each do |web_source|
        mapping = mapper.dig(web_source.slug)
        events = EventScrapperService.new(web_source.url, mapping).parse_events
        web_source.cultural_activities.create(events)
      end
    end

  end
end