class Guide

  # having an argument will allow us to have different files potentially (ex. guide for San Francisco, a guide for Columbus, a guide for New York)
  def initialize(path=nil) 
    # locate the restaurant text file at path 
    # or 
    # create new file
    # exit if create files fails

  end

  def launch!
    introduction 
    # action loop
    #   what do you want to do?(list, find, add, quit)
    #   do that action
    # repeat until user quits
    conclusion
  end

  def introduction
    puts "\n\n <<< Welcome to food finder >>> \n\n\n"
    puts "This is an interactive guide to help you find the food you like. \n\n"
    
  end

  def conclusion
    puts "\n <<< Goodbye and Buen Provecho! >>> \n\n\n"
  end


end