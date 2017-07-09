require 'open-uri'
require 'tsumamigui/error'
require 'tsumamigui/response'

module Tsumamigui
  class Request
    class << self
      # @param [String] urls
      # @param [Array<String>] urls
      # @return [Array<Tsumamigui::Response>]
      def run(*urls)
        new(urls).send(:run)
      end
    end

    INTERVAL = 1.0..3.0 # sec

    attr_reader :urls

    # @param [String] urls
    # @param [Array<String>] urls
    def initialize(*urls)
      @urls = urls.flatten
      raise ArgumentError, 'No argument is specified' if @urls.empty?
      @urls
    end

    private

    # @return [Array<Tsumamigui::Response>]
    def run
      results = []
      @urls.each do |url|
        results.push(fetch(url))
      end
      results
    end

    # @param [String] url
    # @return [Tsumamigui::Response] response
    # @raise [Tsumamigui::RequestError]
    def fetch(url)
      charset = nil
      sleep(sleep_interval)
      html = open(url, request_options) do |f|
        charset = f.charset
        f.read
      end

      Response.new(url, html, charset)
    rescue => e
      raise RequestError, e.message
    end

    # @return [Float] sec 1.0-3.0秒
    def sleep_interval
      Random.rand(INTERVAL)
    end

    # @return [Hash] options
    def request_options
      homepage = 'https://github.com/obiyuta/tsumamigui'
      {'User-Agent' => "Tsumamigui/#{Tsumamigui::VERSION} (+#{homepage})"}
    end
  end
end
