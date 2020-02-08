require 'open-uri'
require 'nokogiri'

class GopressScrapping
  def scrap_articles(file, params)
    html_file = open(file).read
    html_doc = Nokogiri::HTML(html_file)
    html_doc.search('.export-article').map do |element|
      params.merge(
        title: scrap_title(element),
        body: scrap_body(element),
        source_name: scrap_source(element),
        publication_date: scrap_date(element),
        source_url: scrap_sourcepdf(element)
      )
    end
  end

  private

  def scrap_title(element)
    return element.search('h3').first.text
  end

  def scrap_source(element)
    return element.search('.export-article-publication').first.text
  end

  def scrap_date(element)
    return element.search('.export-article-date').first.text
  end

  def scrap_sourcepdf(element)
    return element.search('a.imgThumbmail').first
  end

  def scrap_body(element)
    return element.search('p')
  end

  # def nokogiri_file(file)
  #   html_file = open(file).read
  #   html_doc = Nokogiri::HTML(html_file)
  # end
end
