require_relative('./game.rb')

class Adjuster
  def initialize(adjustments)
    @adjustments = adjustments
  end

  def adjustment(position)
    @adjustments[position]
  end

end