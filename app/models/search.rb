class Search
  include ActiveModel::Model
  include ActiveModel::Validations

  Sectors = ['Sector', 'Government', 'Catholic', 'Independent']
  AutismClassifications = ['Autism Classification']
  SchoolTypes = ['Type', 'Primary', 'Secondary']

  attr_accessor(
    :lat,
    :lng,
    :suburb,
    :school_type,
    :autism_classification,
    :sector,
    :page
  )

  def results
    School.near(point).limit(10).offset(page.to_i * 10)
  end

  def atlas_id
    @atlas_id
  end

  def atlas_id=(value)
    return if value.blank?
    @atlas_id = value
    p = Atlas.all[value] or raise ActiveRecord::RecordNotFound.new("atlas_id not found")
    self.lat = p.y
    self.lng = p.x
  end

  def point
    ActiveRecord::Point.new(lng, lat)
  end

  validates :lat, :lng, presence: true
  validates :sector, inclusion: Sectors
  validates :autism_classification, inclusion: AutismClassifications
  validates :school_type, inclusion: SchoolTypes
end