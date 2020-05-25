require 'pry'
require 'httparty'


class Covidstats::API
   def self.get_reports
    site = HTTParty.get("https://covid19api.io/api/v1/AllReports")
    reports = site["reports"]
    reports = reports[0]["table"][0] #array of hashes that are all the reports/stats per country
  
    # 217 countries
    #reports[0]["Country"] #"World", can iterate over the number to get the countries
    
    #binding.pry
   end
 end