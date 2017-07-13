module Tsumamigui
  class Response
    # request url
    attr_reader :url
    # fetched html
    attr_reader :html
    # charset of fetched html
    attr_reader :charset

    # @param [String] url
    # @param [String] html
    # @param [String] charset
    def initialize(url, html, charset)
      @url = url
      @html = html
      @charset = charset
    end

    # Convert request data to array
    # @return [Array] [url, html, charset]
    def to_array
      [@url, @html, @charset]
    end
  end
end
