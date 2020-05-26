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
  
   attr_accessor :total_cases, :new_cases, :total_deaths, :new_deaths, :total_recovered, :active_cases, :total_tests, :population, :continent, :deaths_per_mil, :serious_critical, :tests_per_mil, :total_cases_per_mil
  @@all = [] #array of all the country instances
  
  
  # def initialize(country_name)
  # @name = country_name
  # select_hash(country_name)  #select the hash where @name == hash["Country"]
  # save
  # #binding.pry
  # end
  
  def initialize(country_hash)
    hash_attr(country_hash)
    save
  end
  
  
  # def select_hash(name)
  #   hashlist = Covidstats::API.get_reports.select {|hash| hash["Country"] == name} #this is still an array
  #   hash_attr(hashlist[0])
  # end
  
  def hash_attr(hash)      #given a hash, returns all the attributes
    hash = hash.each {|key, value| hash[key] = value.gsub(",","").gsub("+","")}
    @total_cases = hash.values[1]
    @new_cases = hash.values[2]
    @total_deaths = hash.values[3]
    @new_deaths = hash.values[4]
    @total_recovered = hash.values[5]
    @active_cases = hash.values[6]
    @total_tests = hash.values[7]
    @population = hash.values[8]
    @continent = hash.values[9]
    @deaths_per_mil = hash.values[10]
    @name = hash.values[11]
    @serious_critical = hash.values[12]
    @tests_per_mil = hash.values[13]
    @total_cases_per_mil = hash.values[14]
  end
  

  def self.get_reports
    Covidstats::API.get_reports #list of hashes
  end
  
  def self.create_from_collection(countries_array)
    countries_array.each{|country| self.new(country)} #country is a hash
  end
  
  def self.all
    get_reports if @@all = []
    @@all
  end
  
  def save
    @@all << self
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