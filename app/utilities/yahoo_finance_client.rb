
class YahooFinanceClient

  def get_stats(symbol)
    stats = {}
    html = get_html(symbol)
    keys = get_keys(html)
    values = get_values(html)
    # make a hash out of the arrays
    keys.each_with_index do |key, index|
      stats[key] = values[index]
    end
    stats

    # one-liner
    stats = Hash[keys.zip(values)]
  end


  def get_html(symbol)
    url = "http://finance.yahoo.com/q/ks?s=AAPL+Key+Statistics"
    response = HTTParty.get(url)
    response.body
  end


  def get_keys(html)
    doc = Nokogiri::HTML(html)
    elements = doc.css('.yfnc_tablehead1')
    keys = elements.map { |e| clean_text(e.text) }
  end

  def get_values(html)
    doc = Nokogiri::HTML(html)
    elements = doc.css('.yfnc_tabledata1')
    keys = elements.map { |e| e.text }
  end

  def clean_text(text)
    text.gsub!(/:/, '')
    text.gsub!(/\d/, '')
    text.gsub!(/\(.*\)/, '')
    text.strip
  end


end