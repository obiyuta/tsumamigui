require 'nokogiri'
require 'tsumamigui/error'

module Tsumamigui
  class Parser
    # xpath to getting the data from
    attr_reader :xpath

    class << self
      # @param [Array<Tsumamigui::Response>] responses
      # @param [Hash] xpath
      # @return [Array<Hash>] parsed responses
      def parse(responses, xpath)
        new(xpath).send(:parse, responses)
      end
    end

    # @param [Hash] xpath Name and xpath to it
    def initialize(xpath)
      @xpath = xpath
    end

    private

    # Parse response data into hash object
    # @param [Array<Tsumamigui::Response>] responses
    # @return [Array<Hash>] parsed responses
    # @raise [Tsumamigui::ParserError]
    def parse(responses)
      results = []
      responses.each do |res|
        url, html, charset = res.to_array
        result = extract(Nokogiri::HTML.parse(html, nil, charset))
        result[:scraped_from] = url
        results.push(result)
      end
      results
    rescue => e
      raise ParserError, e.message
    end

    # Extract data from parsed html with xpath
    # @param [Object] document Nokogiri::HTML::Document
    # @return [Hash] xpath and its key
    # @raise [Tsumamigui::ParserError]
    def extract(document)
      result = {}
      @xpath.each do |k, v|
        result[k] = document.xpath(v).to_s
      end
      result
    rescue => e
      raise ParserError, e.message
    end
  end
end
