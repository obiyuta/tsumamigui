RSpec.describe Tsumamigui::Request do
  let(:url) { 'http://example.com' }
  let(:klass) { described_class }
  let(:instance) { klass.new(url) }

  let(:html) { fixture('htmls/example.com.html') }
  let(:charset) { 'utf-8' }
  let(:headers) { {'Content-Type' => "text/html; charset=#{charset}"} }
  before do
    WebMock.stub_request(:get, url)
           .to_return(body: html, status: 200, headers: headers)
    WebMock.stub_request(:get, File.join(url, '404'))
           .to_return(body: html, status: 404)
  end

  shared_examples 'Tsumamigui::Response' do
    it 'has url, html and charset' do
      expect(response.url).to eq url
      expect(response.html).to eq html
      expect(response.charset).to eq charset
    end

    it 'has #to_array method' do
      expect(response.to_array).to eq [url, html, charset]
    end
  end

  context 'class method' do
    describe '.run' do
      context 'when a url is given' do
        let(:result) { klass.run(url) }
        let(:response) { result[0] }

        it 'returns array with a element' do
          expect(result.size).to eq 1
        end
        it_behaves_like 'Tsumamigui::Response'
      end

      context 'when urls as muitple arguments are given' do
        let(:result) { klass.run(url, url) }
        let(:response) { result[0] }

        it 'returns array with 2 elements' do
          expect(result.size).to eq 2
        end
        it_behaves_like 'Tsumamigui::Response'
      end

      context 'when an array is given' do
        let(:result) { klass.run([url]) }
        let(:response) { result[0] }

        it 'returns array with a element' do
          expect(result.size).to eq 1
        end
        it_behaves_like 'Tsumamigui::Response'
      end
    end
  end

  describe '#initialize' do
    context 'when a url is specified' do
      it 'uses that url with pushing into array' do
        expected = [url]
        expect(instance.urls).to eq expected
      end
    end

    context 'when urls are specified as muitiple arguments' do
      it 'uses that urls' do
        instance = klass.new(url, url)
        expected = [url, url]
        expect(instance.urls).to eq expected
      end
    end

    context 'when urls is not specified' do
      it 'raises error' do
        expect { klass.new }.to raise_error ArgumentError
      end
    end
  end

  describe '#run' do
    let(:result) { instance.send(:run) }
    let(:response) { result[0] }

    it 'returns array' do
      expect(result.is_a?(Array)).to be_truthy
    end
    it_behaves_like 'Tsumamigui::Response'
  end

  describe '#fetch' do
    it 'takes more than 1.0sec' do
      start_time = Time.now
      instance.send(:fetch, url)
      end_time = Time.now - start_time
      expect(end_time).to be >= 1.0
    end

    context 'if url returns 200' do
      let(:response) { instance.send(:fetch, url) }

      it_behaves_like 'Tsumamigui::Response'
    end

    context 'if url returns 404' do
      it 'raises error' do
        expect do
          instance.send(:fetch, File.join(url, '404'))
        end.to raise_error Tsumamigui::RequestError
      end
    end
  end

  describe '#sleep_interval' do
    it 'returns a number between 1.000 and 3.000' do
      [1..5].each do |_|
        sec = instance.send(:sleep_interval)
        expect(sec).to be >= 1.0
        expect(sec).to be <= 3.0
      end
    end
  end

  describe '#request_options' do
    let(:opt) { instance.send(:request_options) }
    let(:ua) do
      homepage = 'https://github.com/obiyuta/tsumamigui'
      "Tsumamigui/#{Tsumamigui::VERSION} (+#{homepage})"
    end

    it 'has User-Agent' do
      expect(opt['User-Agent']).to eq ua
    end
  end
end
