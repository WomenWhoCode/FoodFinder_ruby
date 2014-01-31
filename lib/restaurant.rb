# Now we could just put that functionality on the guide.rb in initialize method. But that's not the best option
# because that will not be object-oriented . Instead, it's going to be much better to have a restaurant class and 
# put all of the functionality of dealing with that data file in the restaurant class.

class Restaurant
  # a class variable here for the file path, so we dont need an instance to have the file path
  @@filepath = nil

  def self.filepath=(path=nil)
    # The APP_ROOT will assume that the path will always have to be relative to the app root
    @@filepath = File.join(APP_ROOT, path)
  end
  # class methods here: 
  # file_exists? is a method so that restaurant class should know whether its file exists or not, if not, it will know how to create a file
  def self.file_exists?
    #class should know if the restaurant file exists 
  end

  def self.create_file
    #create the restaurant file
  end

  def self.saved_restaurants
    #read the restaurant file
    # return instances of restaurant
  end

end