#!/usr/bin/env ruby

require 'nokogiri'
require 'open-uri'

feed = 'http://www.cheburek.net/' #enter Feed num 1

def parse feed
  doc = Nokogiri::HTML(open(feed))
  doc.css('div.left_articles').map do |doc_article|
    item = {}
    item[:link] = doc_article.at_css('h2 a')[:href]
    item[:title] = doc_article.css('.title').text
    item[:summary] = doc_article.css('p')[3].text
    item
  end
end

@article = parse feed
p @article