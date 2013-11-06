class YahooFinanceClient

  def initialize
  end

  def get_stats(symbol)
    html = get_html(symbol)
    keys = get_keys(html)
    values = get_values(html)
    # convert keys, values to Hash
    stats = {}
    keys.each_with_index do |key, index|
      stats[key] = values[index]
    end
    stats

    # one-liner
    stats = Hash[keys.zip(values)]

  end

  def get_keys(html)
    doc = Nokogiri::HTML(html)
    keys = doc.css('.yfnc_tablehead1') # returns Nokogiri::XML::Element
    keys = keys.map { |k| clean_html(k.inner_html) }
  end

  def get_values(html)
    doc = Nokogiri::HTML(html)
    keys = doc.css('.yfnc_tabledata1') # returns Nokogiri::XML::Element
    keys = keys.map { |k| clean_html(k.inner_html) }
  end

  def clean_html(html)
    doc = Nokogiri::HTML(html)
    doc.css('sup').remove
    text = doc.text
    text.gsub!(/\(.*\)/, '')
    text.gsub!(/:/, '')
    text.strip
  end

  def parse_html(html)
    doc = Nokogiri::HTML(html)
    keys = doc.css('.yfnc_tablehead1')
    values = doc.css('.yfnc_tabledata1')
    keys = keys.map { |k| k.text }
    values = values.map { |v| v.text }
    stats = Hash[keys.zip(values)]
  end




  # not tested
  def get_html(symbol)
    url = get_key_statistics_url(symbol)
    response = HTTParty.get(url)
    html = response.body
  end

  def get_key_statistics_url(symbol)
    "http://finance.yahoo.com/q/ks?s=#{symbol}+Key+Statistics"
  end
end