require 'nokogiri'
require 'tsumamigui/error'

module Tsumamigui
  class Parser
    attr_reader :xpath

    class << self
      # @param [Array<Tsumamigui::Response>] responses
      # @param [Hash] xpath
      # @return [Array<Hash>]
      def parse(responses, xpath)
        new(xpath).send(:parse, responses)
      end
    end

    # @param [Hash] xpath Name and xpath to it
    def initialize(xpath)
      @xpath = xpath
    end

    private

    # @return [Array<Tsumamigui::Response>] responses
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

    # @param [Object] document Nokogiri::HTML::Document
    # @return [Hash]
    # @raise [Tsumamigui::ParserError]
    def extract(doc)
      result = {}
      @xpath.each do |k, v|
        result[k] = doc.xpath(v).to_s
      end
      result
    rescue => e
      raise ParserError, e.message
    end
  end
end
