require 'pry'
class Covidstats::Covid
  #"TotalCases"=>"5,490,720",
  # "NewCases"=>"+92,770",
  # "TotalDeaths"=>"346,319",
  # "NewDeaths"=>"+2,711",
  # "TotalRecovered"=>"2,298,806",
  # "ActiveCases"=>"2,845,595",
  # "TotalTests"=>"",
  # "Population"=>"",
  # "Continent"=>"All",
  # "Deaths_1M_pop"=>"44.4",
  # "Country"=>"World",
  # "Serious_Critical"=>"53,228",
  # "Tests_1M_Pop"=>"",
  # "TotCases_1M_Pop"=>"704"},
  
  
  
  
  
  def self.get_reports
    Covidstats::API.get_reports #hashes
  end
  
  def self.get_world_stats
    @world_report = self.get_reports[0] #hash for get_world_stats
    @world_report.each do |key, value|
      if key != "Country" && key != "#" && value != ""
        value = value.gsub(",","").gsub("+","")
        puts "#{key}: #{value}"
      end
    end
  end
  
  
    # world = @world_report["Country"]
    # puts "#{world}"
end