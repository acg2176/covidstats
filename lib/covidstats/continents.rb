class Covidstats::Continents
  attr_accessor :total_cases, :new_cases, :total_deaths, :new_deaths, :total_recovered, :active_cases, :total_tests, :name, :serious_critical
  @@all = []
  
  # def initialize(continent_name)
  #   @continent = continent_name
  #   merge_hash(continent_name) #select the list of hash by the specified continent and gets the attributes
  #   save
  # end
  
  def initialize(continent_hash) #hash is aggregated hash
    hash_attr(continent_hash)
    save
  end

  #find way to loop this
  def self.continent_reports #for continents: list of hashes per continent
    continents_array = []
    hash_continents = Covidstats::API.get_reports #list of all hashes
    
    asia = hash_continents.select{|hash| hash["Continent"] == "Asia"} #list of hashes only for asia
    continents_array << merge_hash(asia)
    
    africa = hash_continents.select{|hash| hash["Continent"] == "Africa"}
    continents_array << merge_hash(africa)
    
    europe = hash_continents.select{|hash| hash["Continent"] == "Europe"} 
    continents_array << merge_hash(europe)
    
    n_america = hash_continents.select{|hash| hash["Continent"] == "North America"} 
    continents_array << merge_hash(n_america)
    
    s_america = hash_continents.select{|hash| hash["Continent"] == "South America"}
    continents_array << merge_hash(s_america)
    
    australia = hash_continents.select{|hash| hash["Continent"] == "Australia/Oceania"}
    continents_array << merge_hash(australia)
    
    continents_array #list of hashes of the continents 6 total
  end
  
  def self.create_from_collection(continents_array)
    continents_array.each do |continent| #this is a hash
      self.new(continent)
    end
  end
  
  #merge hashes in the array and aggregate the values
  def merge_hash(continents_array)
    new_hash = {}
    new_hash["TotalCases"] = 0 
    new_hash["NewCases"] = 0
    new_hash["TotalDeaths"] = 0 
    new_hash["NewDeaths"] = 0 
    new_hash["TotalRecovered"] = 0 
    new_hash["ActiveCases"] = 0 
    new_hash["TotalTests"] = 0
    new_hash["Serious_Critical"] = 0
    continents_array.each do |hash|
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
    new_hash #new merged hash with aggregate values {} 
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
    @total_cases = hash["TotalCases"]
    @new_cases = hash["NewCases"]
    @total_deaths = hash["TotalDeaths"]
    @new_deaths = hash["NewDeaths"]
    @total_recovered = hash["TotalRecovered"]
    @active_cases = hash["ActiveCases"]
    @total_tests = hash["TotalTests"]
    @name = hash["Continent"]
    @serious_critical = hash["Serious_Critical"]
  end
  
  def save
    @@all << self
  end
  
  def self.all
    @@all
  end
  
  
  
end