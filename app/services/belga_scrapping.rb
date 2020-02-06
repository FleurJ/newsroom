require 'open-uri'
require 'nokogiri'

class BelgaScrapping
  def scrap_title(file)
    html_file = open(file).read
    html_doc = Nokogiri::HTML(html_file)
    html_doc.search('h3').each do |element|
      return element.text.strip
    end
  end

  def scrap_body
    html_file = open(file).read
    html_doc = Nokogiri::HTML(html_file)
    body = []
    html_doc.search('.body-wrap p').each do |element|
      body << element.text.strip
    end
    return body.join.split('Keywords:')[0]
  end

  def fill_fields
    @article.title = scrap_title
    @article.body = scrap_body
    @article.source_name = "Belga"
    @article.publication_date = Date.today.to_s
  end
end
