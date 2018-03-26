# PHASE 2
def convert_to_int(str)
    Integer(str)
  rescue ArgumentError => e
    #puts e.message
    puts nil
end

# convert_to_int('_')

# PHASE 3
FRUITS = ["apple", "banana", "orange"]

def reaction(maybe_fruit)
  if FRUITS.include? maybe_fruit
    puts "OMG, thanks so much for the #{maybe_fruit}!"
  elsif maybe_fruit == "coffee"
    raise TypeError
  else
    raise StandardError
  end
end

def feed_me_a_fruit

  puts "Hello, I am a friendly monster. :)"

  puts "Feed me a fruit! (Enter the name of a fruit:)"
  begin
    maybe_fruit = gets.chomp
    reaction(maybe_fruit)
  rescue TypeError
    puts "Gross. Give me a better fruit."
    retry
  end
end

# feed_me_a_fruit

# PHASE 4
class BestFriend
  class NotARealFriendError < StandardError
    def initialize(message)
      super(message)
    end
  end
  def initialize(name, yrs_known, fav_pastime)
    if yrs_known < 5
      raise NotARealFriendError.new("You've known each other less than 5 years")
    elsif name.length <= 0
      raise "Give me a name, silly!"
    elsif fav_pastime.length <= 0
      raise "What's your favorite pastime?"
    end
    @name = name
    @yrs_known = yrs_known
    @fav_pastime = fav_pastime
  end

  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known}. Let's be friends for another #{1000 * @yrs_known}."
  end

  def do_friendstuff
    puts "Hey bestie, let's go #{@fav_pastime}. Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me."
  end
end

# bf = BestFriend.new("", 5, "baseball")
 bf = BestFriend.new("bib", 4, "football")
#bf = BestFriend.new("john", 5, "basketball")
