require 'support/number_helper'
# Now we could just put that functionality on the guide.rb in initialize method. But that's not the best option
# because that will not be object-oriented . Instead, it's going to be much better to have a restaurant class and 
# put all of the functionality of dealing with that data file in the restaurant class.

class Restaurant
  include NumberHelper
  # a class variable here for the file path, so we dont need an instance to have the file path
  @@filepath = nil

  def self.filepath=(path=nil)
    # The APP_ROOT will assume that the path will always have to be relative to the app root
    @@filepath = File.join(APP_ROOT, path)
  end

  attr_accessor :name, :cuisine, :price
  # class methods here: 
  # file_exists? is a method so that restaurant class should know whether its file exists or not, if not, it will know how to create a file
  def self.file_exists?
    #class should know if the restaurant file exists 
    if @@filepath && File.exists?(@@filepath)
      return true
    else
      return false 
    end
  end

# Replace file_exists? for file_usable including a better naming and code to apply the right code for the right responsibility of it 
  def self.file_usable?
    return false unless @@filepath
    return false unless File.exists?(@@filepath)
    return false unless File.readable?(@@filepath)
    return false unless File.writable?(@@filepath)
    return true 
  end

  def self.create_file
    #create the restaurant file
    File.open(@@filepath, "w") unless file_exists?
    return file_usable?
  end

  def self.saved_restaurants
    #read the restaurant file
    # return instances of restaurant
    restaurants = []
    if file_usable?
      file = File.new(@@filepath, 'r')
      file.each_line do |line|
        restaurants << Restaurant.new.import_line(line.chomp)
      end
      file.close
    end
    return restaurants
  end

  def self.build_using_questions
    args = {}
    print "Restaurant name: "
    args[:name] = gets.chomp.strip

    print "Cuisine type: "
    args[:cuisine] = gets.chomp.strip

    print "Average Price: "
    args[:price] = gets.chomp.strip 
    return self.new(args)
  end

  def initialize(args={})
    @name = args[:name]       || ""
    @cuisine = args[:cuisine] || ""
    @price = args[:price]     || ""
  end

  def import_line(line)
    line_array = line.split("\t")
    @name, @cuisine, @price = line_array
    return self
  end

  def save
    return false unless Restaurant.file_usable?
    File.open(@@filepath, 'a') do |file|
      file.puts "#{[@name, @cuisine, @price].join("\t")}\n"
    end
    return true
  end

   def formatted_price
    number_to_currency(@price)
  end

end