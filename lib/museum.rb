class Museum
  attr_reader :name, :exhibits, :patrons

  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end

  def exhibit_names
    exhibit_names = @exhibits.map do |exhibit|
      exhibit.name
    end
  end

  def recommend_exhibits(patron)
    # exhibit_names = @exhibits.map do |exhibit|
    #   exhibit.name
    # end

    common = exhibit_names & patron.interests
    common.map do |common|
      @exhibits.find_all do |exhibit|
        # require "pry"; binding.pry
      exhibit.name == common
      end
    end.flatten
  end

  def admit(patron)
    @patrons << patron
  end

  def patrons_by_exhibit_interest
    # array of patrons
    # find interests for each patron
    # map to exhibit
    stuff = @patrons.map do |patron|
      recommend_exhibits(patron)
    end
    # @exhibits.group_by |exhibit|
    #   exhibit ==
    @exhibits.reduce({}) do |hash, exhibit|
      hash[exhibit] = @patrons.map do |patron|
                        require "pry"; binding.pry
                        patron.interests
                      end
      hash
    end


    thing = @exhibits.group_by do |exhibit|
      recommend_exhibits(patron)
    end

    # grouped_by_name = @exhibits.group_by do |exhibit|
    #   exhibit.name
    #
    #   # @patrons.each do |patron|
    #   #   recommend_exhibits(patron)
    # end
    # @patrons.reduce({}) do |hash, patron|
    #   recommend_exhibits(patron).each do |exhibit|
    #     hash[exhibit] = patron
    #   end
      # hash
    # end
  end
end
