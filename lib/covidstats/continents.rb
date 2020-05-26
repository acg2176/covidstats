class Covidstats::Continents
  attr_accessor :total_cases, :new_cases, :total_deaths, :new_deaths, :total_recovered, :active_cases, :total_tests, :serious_critical
  @@all = []
  
  def initialize(continent_name)
    @continent = continent_name
    merge_hash(continent_name) #select the list of hash by the specified continent and gets the attributes
    save
  end
  
  def continent_reports(continent) #for continents: list of hashes per continent
    hash_continents = Covidstats::API.get_reports #list of all hashes
    if continent == "Asia"
      hash_continents.select{|hash| hash["Continent"] == "Asia"} 
    elsif continent == "Africa"
      hash_continents.select{|hash| hash["Continent"] == "Africa"}
    elsif continent == "Europe"
      hash_continents.select{|hash| hash["Continent"] == "Europe"} 
    elsif continent == "North America"
      hash_continents.select{|hash| hash["Continent"] == "North America"} 
    elsif continent == "South America"
      hash_continents.select{|hash| hash["Continent"] == "South America"}
    elsif continent == "Australia"
      hash_continents.select{|hash| hash["Continent"] == "Australia/Oceania"}
    end
  end
  
  #merge hashes in the array and aggregate the values
  def merge_hash(continent_name)
    new_hash = {}
    new_hash["TotalCases"] = 0 
    new_hash["NewCases"] = 0
    new_hash["TotalDeaths"] = 0 
    new_hash["NewDeaths"] = 0 
    new_hash["TotalRecovered"] = 0 
    new_hash["ActiveCases"] = 0 
    new_hash["TotalTests"] = 0
    new_hash["Serious_Critical"] = 0
    continent_reports(continent_name).each do |hash|
      #change the strings into integers; remove string keys and aggregate the values
      hash.each do |key, value|
        if key != "Country" && key != "" && key != "Deaths_1M_pop" && key != "TotCases_1M_Pop" && key != "Population" && key != "Tests_1M_Pop"
          hash[key] = value.gsub(",","").gsub("+","")
          hash[key] = hash[key].to_i #FIXED
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
          elsif key == "Serious_Critical"
            new_hash["Serious_Critical"] += hash[key]
          end
        end
      end
    end
    hash_attr(new_hash) #new merged hash with aggregate values {} 
      #{"TotalCases"=>1916177,
  # "NewCases"=>0,
  # "TotalDeaths"=>168515,
  # "NewDeaths"=>0,
  # "TotalRecovered"=>892469,
  # "ActiveCases"=>591308,
  # "TotalTests"=>32582382,
  # "Serious_Critical"=>9915}
  end
  
  def hash_attr(hash)      #given a hash, returns all the attributes
    @total_cases = hash["TotalCases"] if hash.include?("TotalCases")
    @new_cases = hash["NewCases"] if hash.include?("NewCases")
    @total_deaths = hash["TotalDeaths"] if hash.include?("TotalDeaths")
    @new_deaths = hash["NewDeaths"] if hash.include?("NewDeaths")
    @total_recovered = hash["TotalRecovered"] if hash.include?("TotalRecovered")
    @active_cases = hash["ActiveCases"] if hash.include?("ActiveCases")
    @total_tests = hash["TotalTests"] if hash.include?("TotalTests")
    #@population = hash["Population"] if hash.include?("Population")
   #@continent = hash["Continent"] if hash.include?("Continent")
    #@deaths_per_mil = hash["Deaths_1M_pop"] if hash.include?("Deaths_1M_pop")
    @serious_critical = hash["Serious_Critical"] if hash.include?("Serious_Critical")
    #@tests_per_mil = hash["Tests_1M_Pop"] if hash.include?("Tests_1M_Pop")
   # @total_cases_per_mil = hash["TotCases_1M_Pop"] if hash.include?("TotCases_1M_Pop")
  end
  
  def save
    @@all << self
  end
  
  def self.all
    @@all
  end
  
  
  
end