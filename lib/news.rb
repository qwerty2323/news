#!/usr/bin/env ruby

require 'sinatra'
require 'nokogiri'
require 'open-uri'

feed = 'http://www.cheburek.net/'

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

get '/' do
  @articles = parse feed
  erb :index
end

__END__

@@index
<!DOCTYPE html>
<html>
  <head>
  <meta charset="UTF-8">
  <meta name="viewport" content="user-scalable=yes, width=device-width" />
<title>Testing Nokogiri</title> 
</head>
<body>
  <h1>Testing myself with Nokogiri</h1>
  <dl>
    <% @articles.each do |article| %>
      <dt><a href="<%= article[:link] %>"><%= article[:title] %></a></dt>
      <dd><%= article[:summary] %></dd>
    <% end %>
  </dl>
</body>
</html>