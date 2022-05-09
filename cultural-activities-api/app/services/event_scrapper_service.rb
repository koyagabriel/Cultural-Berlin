require_relative 'helpers'
class EventScrapperService
  attr_reader :web_source, :mapping

  def initialize(web_source, mapping)
    raise StandardError.new("(web_source_url) cannot be nil") unless web_source.url.present?
    raise StandardError.new("(mapping) cannot be nil") unless mapping.present?
    @web_source = web_source
    @mapping = mapping
  end

  def parse_events
    html_page = fetch_page web_source.url
    unless  html_page.present?
      puts("No page was found for the web source #{web_source.url}")
      return
    end
    document = Nokogiri::HTML html_page
    parse_mapping = mapping.dig("parser")
    ParserService.new( document, parse_mapping).parse
  end

end
