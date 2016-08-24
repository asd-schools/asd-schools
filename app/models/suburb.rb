require 'csv'

STATES = {
  'VIC' => 'Victoria',
  'NSW' => 'New South Wales',
  'QLD' => 'Queensland',
  'TAS' => 'Tasmania',
  'NT' => 'Northern Territory',
  'SA' => 'South Australia',
  'WA' => 'West Australia',
  'ACT' => 'Australian Capital Territory',
}

Suburb = Struct.new(:postcode, :name, :state, :point) do
  def id
    self
  end

  def long_state
    STATES[state]
  end

  class << self
    def all
      @all ||= load_all
    end


    private

    def load_all(csv="db/australian-postcodes.csv")
      CSV.read(csv).map do |row|
        postcode, suburb, state, lat, lng = *row
        Suburb.new(
          postcode.gsub(/^'/,'').gsub(/'$/,'').rjust(4, '0'),
          suburb.gsub(/^'/,'').gsub(/'$/,''),
          state.gsub(/^'/,'').gsub(/'$/,''),
          ActiveRecord::Point.new(Float(lat), Float(lng))
        )
      end
    end
  end

end
