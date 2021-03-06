class Covidstats::Continents
  attr_accessor :total_cases, :new_cases, :total_deaths, :new_deaths, :total_recovered, :active_cases, :total_tests, :name, :serious_critical
  @@all = []

  def initialize(continent_hash) 
    hash_attr(continent_hash)
    save
  end

  def self.merge_hash(continents_array)
    new_array = []
    continents_array.each do |array|
      new_hash = {}
      new_hash["Continent"] = ""
      new_hash["TotalCases"] = 0 
      new_hash["NewCases"] = 0
      new_hash["TotalDeaths"] = 0 
      new_hash["NewDeaths"] = 0 
      new_hash["TotalRecovered"] = 0 
      new_hash["ActiveCases"] = 0 
      new_hash["TotalTests"] = 0
      new_hash["Serious_Critical"] = 0
      array.each do |hash|
        hash.each do |key, value|
          new_hash["Continent"] = hash["Continent"]
          if key != "Country" && key != "" && key != "Deaths_1M_pop" && key != "TotCases_1M_Pop" && key != "Population" && key != "Tests_1M_Pop" && key != "Continent" && value.class == String
            hash[key] = value.gsub(",","").gsub("+","")
            hash[key] = hash[key].to_i
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
     new_array << new_hash
    end
    new_array
  end

  def self.continent_reports 
    continents_array = []
    hash_continents = Covidstats::API.get_reports
    asia = hash_continents.select{|hash| hash["Continent"] == "Asia"}
    continents_array << asia
    africa = hash_continents.select{|hash| hash["Continent"] == "Africa"}
    continents_array << africa
    europe = hash_continents.select{|hash| hash["Continent"] == "Europe"} 
    continents_array << europe
    n_america = hash_continents.select{|hash| hash["Continent"] == "North America"}
    continents_array << n_america
    s_america = hash_continents.select{|hash| hash["Continent"] == "South America"}
    continents_array << s_america
    australia = hash_continents.select{|hash| hash["Continent"] == "Australia/Oceania"}
    continents_array << australia
    continents_array
  end
  
  def self.create_from_collection(continents_array)
    continents_array.each do |continent| #this is a hash
      self.new(continent)
    end
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