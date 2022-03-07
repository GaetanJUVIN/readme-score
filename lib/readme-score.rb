require 'nokogiri'
require 'net/http'
require 'redcarpet'
require 'uri'
require 'pathname'

require 'json'

require "readme-score/version"
require "readme-score/util"
require "readme-score/document"

module ReadmeScore
  ROOT = File.expand_path(File.join(File.dirname(__FILE__), ".."))

  module_function
  def for(markdown_content)
    document(markdown_content).score
  end

  def document(markdown_content)
    Document.load(markdown_content)
  end
end
