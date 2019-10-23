require 'minitest/autorun'
require 'minitest/pride'
require './lib/exhibit'
require './lib/patron'
require './lib/museum'

class MuseumTest < Minitest::Test

  def setup
    @dmns = Museum.new("Denver Museum of Nature and Science")

    @gems_and_minerals = Exhibit.new("Gems and Minerals", 0)
    @dead_sea_scrolls = Exhibit.new("Dead Sea Scrolls", 10)
    @imax = Exhibit.new("IMAX", 15)

    @bob = Patron.new("Bob", 20)
    @sally = Patron.new("Sally", 20)
  end

  def test_it_exists
    assert_instance_of Museum, @dmns
  end

  def test_it_initializes
    assert_equal "Denver Museum of Nature and Science", @dmns.name
    assert_equal [], @dmns.exhibits
  end

  def test_exhibits_can_be_added_to_museum
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)

    assert_equal 2, @dmns.exhibits.count

    @dmns.add_exhibit(@imax)

    assert_equal [@gems_and_minerals, @dead_sea_scrolls, @imax], @dmns.exhibits
  end

  def test_it_can_recommend_exhibits_based_on_patron_interests
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)
    @bob.add_interest("Dead Sea Scrolls")
    @bob.add_interest("Gems and Minerals")
    @sally.add_interest("IMAX")

    assert_equal [@gems_and_minerals, @dead_sea_scrolls], @dmns.recommend_exhibits(@bob)
    assert_equal [@imax], @dmns.recommend_exhibits(@sally)
  end

  def test_museum_can_list_patrons_that_have_been_admitted
    @dmns.admit(@bob)
    @dmns.admit(@sally)

    assert_equal [@bob, @sally], @dmns.patrons
  end

  def test_museum_can_list_patrons_by_exhibit_interest
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)
    @bob.add_interest("Dead Sea Scrolls")
    @bob.add_interest("Gems and Minerals")
    @sally.add_interest("Dead Sea Scrolls")
    @dmns.admit(@bob)
    @dmns.admit(@sally)
    # require "pry"; binding.pry
    assert_instance_of Hash, @dmns.patrons_by_exhibit_interest
    assert_equal 3, @dmns.patrons_by_exhibit_interest.count
    assert_equal [], @dmns.patrons_by_exhibit_interest[@imax]
  end
end
