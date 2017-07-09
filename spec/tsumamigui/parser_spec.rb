RSpec.describe Tsumamigui::Parser do
  let(:klass) { described_class }
  let(:xpath) { {h1: 'html/body/div/h1/text()'} }

  let(:sample_url) { 'http://example.com' }
  let(:stub) { fixture('htmls/example.com.html') }
  let(:headers) { {'Content-Type' => 'text/html; charset=utf-8'} }
  let(:responses) { Tsumamigui::Request.run(sample_url) }

  before do
    WebMock.stub_request(:get, sample_url)
           .to_return(body: stub, status: 200, headers: headers)
  end

  shared_examples 'parsed result' do
    it 'returns array' do
      expect(result.is_a?(Array)).to be_truthy
    end

    it 'returns specified key/value and scrape url ' do
      expect(element[:h1]).to eq 'Example Domain'
      expect(element[:scraped_from]).to eq sample_url
    end
  end

  context 'class method' do
    describe '.parse' do
      let(:result) { klass.parse(responses, xpath) }
      let(:element) { result[0] }

      it_behaves_like 'parsed result'
    end
  end

  describe '#initialize' do
    context "when xpath is specified" do
      it "uses that xpath" do
        expected = xpath
        instance = klass.new(expected)
        expect(instance.xpath).to eq expected
      end
    end

    context "when xpath is not specified" do
      it "raises error" do
        expect { klass.new }.to raise_error ArgumentError
      end
    end
  end

  describe '#parse' do
    let(:result) { klass.new(xpath).send(:parse, responses) }
    let(:element) { result[0] }

    it_behaves_like 'parsed result'
  end

  describe '#extract' do
    let(:nokogiri_doc) { Nokogiri::HTML.parse(stub) }

    it 'returns data extracted from html by xpath' do
      expected = {h1: 'Example Domain'}
      extracted = klass.new(xpath).send(:extract, nokogiri_doc)
      expect(extracted).to eq expected
    end
  end
end
