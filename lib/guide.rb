require 'restaurant'
require 'support/string_extend'

class Guide
  class Config
    @@actions = ['list', 'find', 'add', 'quit']
    def self.actions; @@actions; end
  end

  # having an argument will allow us to have different files potentially (ex. guide for San Francisco, a guide for Columbus, a guide for New York)
  def initialize(path=nil) 
    # locate the restaurant text file at path 
    Restaurant.filepath = path
    if Restaurant.file_usable?
      puts "Found restaurant file."
    # or 
    # create new file
    elsif  Restaurant.create_file
      puts "Created restaurant file."
      # exit if create files fails
    else
      puts "Exiting.\n\n"
      exit!
    end
  end

  def launch!
    introduction 
    # action loop
    result = nil
    until result == :quit
     action = get_action
     result = do_action(action)
    end
    conclusion
  end

  def get_action
     action = nil
    # Keep asking for user input until we get a valid action
    until Guide::Config.actions.include?(action)
      puts "Actions: " + Guide::Config.actions.join(", ")
      print "> "
      user_response = gets.chomp
      action = user_response.downcase.strip
    end
    return action
  end

  def do_action(action, args=[])
    case action
    when 'list'
      list(args)
    when 'find'
      keyword = args.shift
      find(keyword)
    when 'add'
      add
    when 'quit'
      return :quit
    else 
      puts "\nI don't understand your command .\n"
    end
    
  end

  def add
    puts "\nAdd a restaurant\n\n".upcase 
    restaurant = Restaurant.build_using_questions
    if restaurant.save
      puts "\nRestaurant Added\n\n"
    else
      "\nSave error : Restaurant Added\n\n"
    end
  end

  def list(args=[])
    sort_order = args.shift
    sort_order = args.shift if sort_order == 'by'
    sort_order = "name" unless ['name', 'cuisine', 'price'].include?(sort_order)
    
    output_action_header("Listing restaurants")
    
    restaurants = Restaurant.saved_restaurants
    restaurants.sort! do |r1, r2|
      case sort_order
      when 'name'
        r1.name.downcase <=> r2.name.downcase
      when 'cuisine'
        r1.cuisine.downcase <=> r2.cuisine.downcase
      when 'price'
        r1.price.to_i <=> r2.price.to_i
      end
    end
    output_restaurant_table(restaurants)
    puts "Sort using: 'list cuisine' or 'list by cuisine'\n\n"
  end

   def find(keyword="")
    output_action_header("Find a restaurant")
    if keyword
      restaurants = Restaurant.saved_restaurants
      found = restaurants.select do |rest|
        rest.name.downcase.include?(keyword.downcase) || 
        rest.cuisine.downcase.include?(keyword.downcase) || 
        rest.price.to_i <= keyword.to_i
      end
      output_restaurant_table(found)
    else
      puts "Find using a key phrase to search the restaurant list."
      puts "Examples: 'find tamale', 'find Mexican', 'find mex'\n\n"
    end
  end

  def introduction
    puts "\n\n <<< Welcome to food finder >>> \n\n\n"
    puts "This is an interactive guide to help you find the food you like. \n\n"
    
  end

  def conclusion
    puts "\n <<< Goodbye and Buen Provecho! >>> \n\n\n"
  end

  private
  
  def output_action_header(text)
    puts "\n#{text.upcase.center(60)}\n\n"
  end
  
  def output_restaurant_table(restaurants=[])
    print " " + "Name".ljust(30)
    print " " + "Cuisine".ljust(20)
    print " " + "Price".rjust(6) + "\n"
    puts "-" * 60
    restaurants.each do |rest|
      line =  " " << rest.name.titleize.ljust(30)
      line << " " + rest.cuisine.titleize.ljust(20)
      line << " " + rest.formatted_price.rjust(6)
      puts line
    end
    puts "No listings found" if restaurants.empty?
    puts "-" * 60
  end


end