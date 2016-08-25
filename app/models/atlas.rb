class Atlas
  class << self
    def all
      @all ||= load_all
    end
    def load_all
      h = JSON.parse(File.read("db/atlas_centres.json"))
      puts h.length
      h.each do |k, v|
        if v
          h[k] = ActiveRecord::Point.new(v["lat"], v["lng"])
        else
          h.delete(k)
        end
      end
      h
    end
  end
end
