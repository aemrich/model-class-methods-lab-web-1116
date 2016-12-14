class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.includes(boats: :classifications).where(:classifications => {:name => "Catamaran"})
  end

  def self.sailors
    self.includes(boats: :classifications).where(:classifications => {:name => "Sailboat"}).uniq
  end

  def self.talented_seamen

    captain_ids = self.sailors.pluck(:id)&self.includes(boats: :classifications).where(:classifications => {:name => "Motorboat"}).uniq.pluck(:id)

    self.all.where(:id => captain_ids)

  end

  def self.non_sailors
    sailor_ids = self.sailors.pluck(:id)
    self.where.not(:id => sailor_ids)
  end

end
