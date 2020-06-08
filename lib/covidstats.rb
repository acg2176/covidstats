require 'httparty'
require 'tty-prompt'
require 'colorize'
require 'pry'


require_relative "covidstats/version"
require_relative "covidstats/cli"
require_relative "covidstats/api"
require_relative "covidstats/country"
require_relative "covidstats/continents"

module Covidstats
  class Error < StandardError; end
  # Your code goes here...
end
