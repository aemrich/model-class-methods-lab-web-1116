class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.includes(boats: :classifications).where(:classifications => {:name => "Catamaran"})
  end

  def self.sailors
    self.includes(boats: :classifications).where(:classifications => {:name => "Sailboat"}).uniq
  end

  def self.talented_seamen
    self.includes(boats: :classifications).group('captain.name').where("classifications.name = ? AND classifications.name = ?", 'Sailboat', 'Motorboat')
  end

end
