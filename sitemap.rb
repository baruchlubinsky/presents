require 'rubygems'
require 'sitemap_generator'

SitemapGenerator::Sitemap.default_host = 'http://presentsinthepost.co.za'
SitemapGenerator::Sitemap.create do
  add '/home'
  add '/contact_us'
  add '/get_a_present'
  add '/the_story'
  add '/raj_loves'
  add '/shops'
  add '/posted_presents'
end
SitemapGenerator::Sitemap.ping_search_engines # called for you when you use the rake task