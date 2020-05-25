require 'pry'
require 'httparty'


class Covidstats::API
   def self.get_reports
    site = HTTParty.get("https://covid19api.io/api/v1/AllReports")
    reports = site["reports"]
    reports = reports[0]["table"][0] #array of hashes that are all the reports/stats per country
 
   end
   
  # def self.get_US_state_reports
     
  # end
 end