class Covid::Continents
  attr_accessor :total_cases, :new_cases, :total_deaths, :new_deaths, :total_recovered, :active_cases, :total_tests, :serious_critical
  @@all = []
  
  def initialize(continent_name)
    @continent = continent_name
    continent_reports(continent_name) #select the list of hash by the specified continent
  end
  
  def continent_reports(continent) #for continents: list of hashes per continent
    hash_continents = Covidstats::API.get_reports #list of all hashes 
    hash_continents.select{|hash| hash["Continent"] == "Asia"} if continent == "Asia"
    hash_continents.select{|hash| hash["Continent"] == "Africa"} if continent == "Africa"
    hash_continents.select{|hash| hash["Continent"] == "Europe"} if continent == "Europe"
    hash_continents.select{|hash| hash["Continent"] == "North America"} if continent == "North America"
    hash_continents.select{|hash| hash["Continent"] == "South America"} if continent == "South America"
    hash_continents.select{|hash| hash["Continent"] == "Australia/Oceania"} if continent == "Australia"
  end
  
  #merge hashes in the array and aggregate the values
  def merge_hash(continent) #continent is a list of hashes
    new_hash = {}
    new_hash["TotalCases"] = 0 
    new_hash["NewCases"] = 0
    new_cases["TotalDeaths"] = 0 
    new_cases["NewDeaths"] = 0 
    new_cases["TotalRecovered"] = 0 
    new_cases["ActiveCases"] = 0 
    new_cases["TotalTests"] = 0
    new_cases["Serious_Critical"] = 0
    continent.each do |hash|
      #change the strings into integers; remove country key and aggregate values
      hash.each do |key, value|
        if key != "Country" && key != "" && key != "Deaths_1M_pop" && key != "TotCases_1M_Pop" && key != "Population" && key != "Tests_1M_Pop"
          hash[key] = value.gsub(",","").gsub("+","").to_i
          if key == "TotalCases"
            new_hash["TotalCases"] += hash[key]
          elsif key == "NewCases"
            new_hash["NewCases"] += hash[key]
          elsif key == "TotalDeaths"
            new_hash["TotalDeaths"] += hash[key]
          elsif key == "NewDeaths"
            new_hash["NewDeaths"] += hash[key]
          elsif key == "TotalRecovered"
            new_hash["TotalRecovered"] += hash[key]
          elsif key == "ActiveCases"
            new_hash["ActiveCases"] += hash[key]
          elsif key == "TotalTests"
            new_hash["TotalTests"] += hash[key]
          elsif key = "Serious_Critical"
            new_hash["Serious_Critical"] += hash[key]
          end
        end
      end
    end
    new_hash #new merged hash with aggregate values
  end
  
  
  
end