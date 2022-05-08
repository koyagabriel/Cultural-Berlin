# Seeding Web Sources

web_sources = [
  {name: "CO Berlin", url: "https://co-berlin.org/en/program/calendar", slug: "co_berlin"},
  {name: "Gorki", url: "https://www.gorki.de/en/programme", slug: "gorki"}
]

web_sources.each { |web_source_attr| WebSource.find_or_create_by(web_source_attr) }