class ParserService
  attr_reader :document, :mapping, :details_mapping
  def initialize(document, mapping)
    @document = document
    @mapping = mapping
    @details_mapping = mapping.dig("details")
  end

  def parse
    events_list = get_events_list
    events_list.map { |event| parse_event event }
  end

  private

    def parse_event(event)
      event_details = get_event_details(event)
      event_details
    end

    def get_node(document, path, first: true)
      node = document.css(path)
      first ? node.first : node
    end

    def get_node_content(node, node_type)
      return node unless node.present?
      case node_type.to_s
      when "link"
        node.attributes.dig("href")&.content&.to_s&.strip
      when "img"
        node.attributes.dig("src")&.content&.to_s&.strip
      else
        node&.content&.to_s&.strip
      end
    end

    def merge_url_prefix(suffix_url, url_prefix)
      return suffix_url unless url_prefix.present? && suffix_url.present?
      "#{url_prefix.strip}#{suffix_url.strip}"
    end

    def get_value_with_regex(regex, value)
      return value unless value.present?
      Regexp.new(regex).match(value)&.to_s
    end

    def get_event_attributes
      %w[title description detail_url image_url]
    end

    def get_event_time_attributes
      %w[start_time end_time]
    end

    def get_event_date_attributes
      %w[start_date end_date]
    end

    def get_events_list
      events_path = mapping["events_path"]
      get_node(document, events_path, first: false)
    end

    def get_event_details(event)
      details = HashWithIndifferentAccess.new
      get_event_attributes.each do |attribute|
        details[attribute] = get_attribute_info(event, details_mapping.dig(attribute))
      end

      get_event_time_attributes.each do |attribute|
        details[attribute] = get_time_info(event, details_mapping.dig(attribute))
      end

      get_event_date_attributes.each do |attribute|
        details[attribute] = get_date_info(event, details_mapping.dig(attribute))
      end
      details
    end

    def get_attribute_info(event, attribute_mapping)
      path = attribute_mapping.dig("path")
      if path.present?
        node_type = attribute_mapping.dig("node_type")
        regex = attribute_mapping.dig("regex")
        url_prefix = attribute_mapping.dig("url_prefix")
        node = get_node(event, path)
        content = get_node_content(node, node_type)

        if regex.present?
          content = get_value_with_regex(regex, content)
        end

        if ["link", "img"].include?(node_type.to_s) && url_prefix
          content = merge_url_prefix(content, url_prefix)
        end

        return content
      end
    end

    def get_time_info(event, attribute_mapping)
      time = get_attribute_info(event, attribute_mapping)
      time_format = attribute_mapping.dig("time_format")
      (time && time_format) ? Time.strptime(time, time_format) : time
    end

    def get_date_info(page, attribute_mapping)
      path = attribute_mapping.dig("path")
      if path.present?
        node_type = attribute_mapping.dig("node_type")
        regex_for_day = attribute_mapping.dig(*(%w[day regex]))
        regex_for_month = attribute_mapping.dig(*(%w[month regex]))
        regex_for_year = attribute_mapping.dig(*(%w[year regex]))
        date_format = attribute_mapping.dig("date_format")

        node = get_node(page, path)
        content = get_node_content(node, node_type)
        return nil unless content

        day = get_value_with_regex(regex_for_day, content)
        month = get_value_with_regex(regex_for_month, content)
        year = get_value_with_regex(regex_for_year, content)
        date = "#{day},#{month},#{year}"

        (date && date_format) ? Date.strptime(date, date_format) : date
      end
    end

end
