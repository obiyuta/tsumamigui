module Tsumamigui
  class Response
    attr_reader :url
    attr_reader :html
    attr_reader :charset

    # @param [String] url
    # @param [String] html
    # @param [String] charset
    def initialize(url, html, charset)
      @url = url
      @html = html
      @charset = charset
    end

    # @return [Array]
    def to_array
      [@url, @html, @charset]
    end
  end
end
