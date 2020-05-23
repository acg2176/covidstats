require 'pry'
require 'httparty'

site = HTTParty.get("https://covid19api.io/api/v1/USAMedicalAidDistribution")

binding.pry