require 'open-uri'
require 'nokogiri'

class BelgaScrapping
  def scrap_article(file, params)
    params.merge(
      title: scrap_title(file),
      body: scrap_body(file),
      source_name: "Belga",
      publication_date: Date.today
    )
  end

  def scrap_title(file)
    html_file = open(file).read
    html_doc = Nokogiri::HTML(html_file)
    html_doc.search('h3').each do |element|
      return element.text.strip
    end
  end

  def scrap_body(file)
    html_file = open(file).read
    html_doc = Nokogiri::HTML(html_file)
    body = []
    html_doc.search('.body-wrap p').each do |element|
      body << element.text.strip
    end
    return body.join.split('Keywords:')[0]
  end
end
