def fetch_page(page_url)
  RestClient.get(page_url).body
rescue RestClient::ExceptionWithResponse
  puts("An error occurred when trying to fetch page from #{web_source_url}")
end