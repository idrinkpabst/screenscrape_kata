require 'spec_helper'

describe YahooFinanceClient do

  let(:client) { client = YahooFinanceClient.new }
  
  describe '#get_stats' do
    it do
      stats = client.get_stats('AAPL')
      expect(stats["Market Cap"]).to eq '468.69B'
    end
  end

  describe '#get_html' do
    it do
      html = client.get_html('AAPL')
      expect(html).to start_with "<!DOCTYPE"
    end
  end

  describe '#get_keys' do
    it do
      html = client.get_html('AAPL')
      keys = client.get_keys(html)
      expect(keys[0]).to eq "Market Cap"
    end
  end

  describe '#get_values' do
    it do
      html = client.get_html('AAPL')
      values = client.get_values(html)
      expect(values[0]).to eq "468.69B"
    end
  end

  describe '#clean_text' do
    it do
      dirty_text = "Market Cap (intraday)5:"
      clean_text = client.clean_text(dirty_text)
      expect(clean_text).to eq "Market Cap"
    end
  end
end
