require 'tsumamigui/version'
require 'tsumamigui/request'
require 'tsumamigui/parser'

module Tsumamigui
  class << self
    # @param [String] url
    # @param [Array<String>] url
    # @param [Hash] xpath key and xpath to it
    # @return [Array] parsed contents
    # @example
    #   Tsumamigui.scrape('http://example.com', title: '//div[0]/@content')
    #   # you can specify muitiple urls at once
    #   urls = ['http://example.com', 'http://example.com/sample']
    #   Tsumamigui.scrape(urls, title: '//div[0]/@content')
    def scrape(url, xpath)
      documents = Request.run(url)
      Parser.parse(documents, xpath)
    end
  end
end
