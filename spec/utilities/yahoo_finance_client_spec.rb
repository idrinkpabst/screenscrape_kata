require 'spec_helper'

describe YahooFinanceClient do
  it do
    client = YahooFinanceClient.new
    stats = client.get_stats('AAPL')
    expect(stats['Market Cap']).to eq '473.94B'
  end
end
