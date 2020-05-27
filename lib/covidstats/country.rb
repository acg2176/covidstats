require 'pry'
class Covidstats::Country
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
  
   attr_accessor :total_cases, :new_cases, :total_deaths, :new_deaths, :total_recovered, :active_cases, :total_tests, :population, :continent, :deaths_per_mil, :name, :serious_critical, :tests_per_mil, :total_cases_per_mil
  @@all = [] 
  
  

  def initialize(country_hash)
    hash_attr(country_hash)
    save
  end
  

  
  def hash_attr(hash)      #given a hash, returns all the attributes
    hash = hash.each do |key, value| 
      hash[key] = value.gsub(",","").gsub("+","")
      if key != "Continent" && key != "Country"
        hash[key] = hash[key].to_i
      end
    end
    @total_cases = hash["TotalCases"]
    @new_cases = hash["NewCases"]
    @total_deaths = hash["TotalDeaths"]
    @new_deaths = hash["NewDeaths"]
    @total_recovered = hash["TotalRecovered"]
    @active_cases = hash["ActiveCases"]
    @total_tests = hash["TotalTests"]
    @population = hash["Population"]
    @continent = hash["Continent"]
    @deaths_per_mil = hash["Deaths_1M_pop"]
    @name = hash["Country"]
    @serious_critical = hash["Serious_Critical"]
    @tests_per_mil = hash["Tests_1M_Pop"]
    @total_cases_per_mil = hash["TotCases_1M_Pop"]
  end
  

  def self.get_reports
    Covidstats::API.get_reports #list of hashes
  end
  
  def self.create_from_collection(countries_array)
    countries_array.delete_if { |h| h["Country"] == "World"}
    countries_array.delete_if { |h| h["Country"] == "Total:"}
    countries_array.each do |country|
      self.new(country)
    end     #country is a hash
  end
  
  def self.all
    @@all
  end
  
  def save
    @@all << self #instance
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
  
  
    
  
end