class Covid::Continents
  attr_accessor :total_cases, :new_cases, :total_deaths, :new_deaths, :total_recovered, :active_cases, :total_tests, :serious_critical, :tests_per_mil
  @@all = []
  
  def initialize(continent_name)
    @continent = continent_name
  end
  
  def continent_reports(continent) #for continents: list of hashes per continent
    hash_continents = Covidstats::API.get_reports #list of all hashes 
    asia = hash_continents.select{|hash| hash["Continent"] == "Asia"} if continent == "Asia"
    africa = hash_continents.select{|hash| hash["Continent"] == "Africa"} if continent == "Africa"
    europe = hash_continents.select{|hash| hash["Continent"] == "Europe"} if continent == "Europe"
    north_america = hash_continents.select{|hash| hash["Continent"] == "North America"} if continent == "North America"
    south_america = hash_continents.select{|hash| hash["Continent"] == "South America"} if continent == "South America"
    australia = hash_continents.select{|hash| hash["Continent"] == "Australia/Oceania"} if continent == "Australia"
  end
  
  #merge hashes in the array and aggregate the values
  def merge_hash(continent) #continent is a list of hashes
    continent.each do |hash|
      #change the strings into integers; remove country key and 
      hash.each do |key, value|
        if key != "Country" && key != "" && key != "Deaths_1M_pop" && key != "TotCases_1M_Pop" && key != "Population" && key != "Tests_1M_Pop"
          hash[key] = value.to_i
        end
      end
    end
    
  end
  
end