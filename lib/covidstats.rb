require 'pry'
require 'httparty'


require_relative "covidstats/version"
require_relative "covidstats/cli"
require_relative "covidstats/api"
require_relative "covidstats/covid"

module Covidstats
  class Error < StandardError; end
  # Your code goes here...
end
