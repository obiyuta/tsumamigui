RSpec.describe Tsumamigui::Response do
  let(:klass) { described_class }
  let(:url) { 'http://example.com' }
  let(:html) { fixture('htmls/example.com.html') }
  let(:charset) { 'utf-8' }
  let(:instance) { klass.new(url, html, charset) }

  describe '#initialize' do
    context "when url, html and charset are specified" do
      it "uses that value" do
        expect(instance.url).to eq url
        expect(instance.html).to eq html
        expect(instance.charset).to eq charset
      end
    end

    context "when argumants are not specified correctly" do
      it "raises error" do
        expect { klass.new }.to raise_error ArgumentError
        expect { klass.new(url, html) }.to raise_error ArgumentError
        expect do
          klass.new(url, html, nil, charset)
        end.to raise_error ArgumentError
      end
    end
  end

  describe '#to_array' do
    let(:array) { instance.to_array }

    it 'returns attrs as array' do
      expected = [url, html, charset]
      expect(array).to eq expected
    end
  end
end
