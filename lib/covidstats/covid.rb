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
  
  
  
  
  def hash_attr(hashlist) #list of hashes taken from API get_reports
    #go through the loop and create instance attributes for each key
    #hashlist => self.get_reports
    hashlist.each do |hash|
      @total_cases = hash["TotalCases"]
      @new_cases = hash["NewCases"]
        
    
    end
  end
  
  
  
  def self.get_reports
    Covidstats::API.get_reports #list of hashes
  end
  
  def self.get_world_stats #this method only displays the stats. it does not create an object
    @world_report = self.get_reports[0] #hash for world stats only
    @world_report.each do |key, value|
      if key != "Country" && key != "#" && value != ""
        value = value.gsub(",","").gsub("+","")  #removes + and , signs
        puts "#{key}: #{value}"
      end
    end
  end
  
  
    # world = @world_report["Country"]
    # puts "#{world}"
end