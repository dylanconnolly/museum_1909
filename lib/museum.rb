class Museum
  attr_reader :name, :exhibits

  def initialize(name)
    @name = name
    @exhibits = []
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end

  def recommend_exhibits(patron)
    exhibit_names = @exhibits.map do |exhibit|
      exhibit.name
    end

    common = exhibit_names & patron.interests
    common.map do |common|
      @exhibits.find_all do |exhibit|
        # require "pry"; binding.pry
      exhibit.name == common
      end
    end.flatten
  end
end
