class CrawlCulturalActivities < ApplicationJob
  queue_as :default

  def perform(*args)
    WebSource.fetch_and_persist_activities
  end
end