RSpec.describe Tsumamigui do
  it "has a version number" do
    expect(Tsumamigui::VERSION).not_to be nil
  end

  let(:mod) { described_class }
  let(:xpath) { {h1: 'html/body/div/h1/text()'} }
  let(:sample_url) { 'http://example.com' }
  let(:stub) { fixture('htmls/example.com.html') }
  let(:headers) { {'Content-Type' => 'text/html; charset=utf-8'} }
  let(:response) { Tsumamigui::Request.run(sample_url) }

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

  describe '.scrape' do
    context 'when a url is given' do
      let(:result) { mod.scrape(sample_url, xpath) }
      let(:element) { result[0] }

      it_behaves_like 'parsed result'
      it 'returns array having an element' do
        expect(result.size).to eq 1
      end
    end

    context 'when an array is given' do
      let(:result) { mod.scrape([sample_url, sample_url], xpath) }
      let(:element) { result[0] }

      it_behaves_like 'parsed result'
      it 'returns array having 2 elemenst' do
        expect(result.size).to eq 2
      end
    end
  end
end
