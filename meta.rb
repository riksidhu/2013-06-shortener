### Class store methods, not Objects

# forgot to include accessor for age
class Person
  def initialize(name)
    @name = name
  end
end

jon = Person.new("Jon")

# Object 'jon' cannot find 'name' method
jon.name;  
# => NoMethod...

# reopen class and add name accessor
class Person
  def name
    @name
  end
end

# already instantiated Object 'jon'
# has dynamically aquired a 'name' method.
#
# This works because methods are contained
# in classes, and Ruby uses dynamic method 
# invocation
#
# i.e. the Ruby interpreter looks up the 
# inheritance chain at runtime only in the 
# instant a method is invoked.

jon.name;  
# => Jon

####################################

motto = "Eat green vegetables"

slogan = "We love Metaprogramming and so can you!"

# Explicit receiver in method definition
def motto.slice(*args)
  "How dare you!! Our motto is way better than --#{super}--"
end

motto.slice(0..2)

slogan.slice(0..6)

# every class method is stored in a metaclass

# not added to the MailTruck metaclass, but to the derived class HappyTruck.

class Chef
    attr_reader :name 
    attr_accessor :experience

    def initialize(name, experience)
        @name = name
        @experience = experience
    end

    def self.specialty(craft)
      meta_def :specialty, do 
        "I am a #{craft}!!"
      end 
    end
end

class Baker < Chef
    specialty "Swift Baker"
end 

class Icer < Chef
    specialty "Rad icer"
end 


### Helpers  -- metaid.rb (courtesy of _why)
class Object
    # The hidden singleton lurks behind everyone
    def metaclass
        class << self 
            self
        end
    end

    def meta_eval(&blk)
        metaclass.instance_eval(&blk)
    end

    # Adds methods to a metaclass
    def meta_def(name, &blk)
        meta_eval { define_method name, &blk }
    end
end
