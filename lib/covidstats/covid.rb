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
  
   attr_accessor :total_cases, :new_cases, :total_deaths, :new_deaths, :total_recovered, :active_cases, :total_tests, :population, :continent, :deaths_per_mil, :serious_critical, :tests_per_mil, :total_cases_per_mil
  @@all = [] #array of all the country instances
  
  
  def initialize(country_name)
   @name = country_name
   #select the hash where @name == hash["Country"]
   select_hash(country_name)
   @@all << self
  end
  
  def select_hash(name)
    hashlist = Covidstats::API.get_reports.select {|hash| hash["Country"] == name} #this is still an array
    hash_attr(hashlist[0])
  end
  
  
  def hash_attr(hash)      #given a hash, returns all the attributes
    hash = hash.each {|key, value| hash[key] = value.gsub(",","").gsub("+","")}
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
    #@name = hash["Country"]
    @serious_critical = hash["Serious_Critical"]
    @tests_per_mil = hash["Tests_1M_Pop"]
    @total_cases_per_mil = hash["TotCases_1M_Pop"]
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