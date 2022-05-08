require_relative 'helpers'
class EventScrapperService
  attr_reader :web_source_url, :mapping

  def initialize(web_source_url, mapping)
    raise StandardError.new("(web_source_url) cannot be nil") unless web_source_url.present?
    raise StandardError.new("(mapping) cannot be nil") unless mapping.present?
    @web_source_url = web_source_url
    @mapping = mapping
  end

  def parse_events
    html_page = fetch_page web_source_url
    unless  html_page.present?
      puts("No page was found for the web source #{web_source_url}")
      return
    end
    document = Nokogiri::HTML html_page
    parse_mapping = mapping.dig("parser")
    ParserService.new(document, parse_mapping).parse
  end

end
