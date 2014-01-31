require 'restaurant'

class Guide

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
      #   what do you want to do?(list, find, add, quit)
      print ">"
      user_response = gets.chomp
      #   do that action
      result = do_action(user_response)
      # repeat until user quits
    end
    conclusion
  end

  def do_action(action)
    case action
    when 'list'
      puts "Listing..."
    when 'find'
      puts 'Finding...'
    when 'add'
      puts 'Adding...'
    when 'quit'
      return :quit
    else 
      puts "\nI don't understand your command .\n"
    end
    
  end

  def introduction
    puts "\n\n <<< Welcome to food finder >>> \n\n\n"
    puts "This is an interactive guide to help you find the food you like. \n\n"
    
  end

  def conclusion
    puts "\n <<< Goodbye and Buen Provecho! >>> \n\n\n"
  end


end