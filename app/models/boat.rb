require 'pry'

class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    Boat.limit(5)
    #binding.pry
  end

  def self.dinghy
    Boat.where("length < 20")
  end

  def self.ship
    Boat.where("length > 20")
  end

  def self.last_three_alphabetically
    Boat.order('name DESC').limit(3)
  end

  def self.without_a_captain
    Boat.where(:captain_id => nil)
  end

  def self.sailboats
    Boat.includes(:classifications).where(:classifications => {:name => "Sailboat"})
  end

  def self.with_three_classifications

    Boat.includes(:classifications).group("boats.name").having("count(boats.name) = ?", 3)
  end


end
