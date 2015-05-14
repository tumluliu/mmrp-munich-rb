class StreetJunctions < ActiveRecord::Base
  SRID = -1
  def self.find_nearest(pt, radius = 0.001)
    self.first :conditions => "ST_DWithin(the_geom, ST_GeomFromText('POINT(#{pt.x} #{pt.y})', #{SRID}), #{radius})",
      :order => "ST_Distance(the_geom, ST_GeomFromText('POINT(#{pt.x} #{pt.y})', #{SRID}))"
  end

  def self.find_farthest(pt, radius = 0.001)
    self.first :conditions => "ST_DWithin(the_geom, ST_GeomFromText('POINT(#{pt.x} #{pt.y})', #{SRID}), #{radius})",
      :order => "ST_Distance(the_geom, ST_GeomFromText('POINT(#{pt.x} #{pt.y})', #{SRID})) DESC"
  end
end
