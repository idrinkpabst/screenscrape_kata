require 'spec_helper'

describe YahooFinanceClient do
  before do
    allow_any_instance_of(YahooFinanceClient).to receive(:get_html).and_return(html)
  end
  let(:client) { YahooFinanceClient.new }
  let(:html) { File.read(File.join('spec', 'fixtures', 'yahoo_finance_AAPL.html')) }

  describe '#get_html' do
    it do
      html = client.get_html('AAPL')
      expect(html).to_not be_blank
      expect(html[0..14].strip).to eq "<!DOCTYPE html"
    end
  end
  describe '#get_stats' do
    it 'acts like stats hash' do
      stats = client.get_stats('AAPL')
      expect(stats).to respond_to(:keys)
      expect(stats).to respond_to(:values)
    end
    it 'gets stats' do
      stats = client.get_stats('AAPL')
      expect(stats['Market Cap']).to eq '473.94B'
    end
  end

  describe '#get_keys' do
    it do
      keys = client.get_keys(html)
      expect(keys[0]).to eq 'Market Cap'
    end
  end


  describe '#get_values' do
    it do
      values = client.get_values(html)
      expect(values[0]).to eq '473.94B'
    end
  end

  describe '#clean_html' do
    it do
      dirty_html = "Market Cap (intraday)<font size=\"-1\"><sup>5</sup></font>:"
      result = client.clean_html(dirty_html)
      expect(result).to eq 'Market Cap'
    end
  end



end
