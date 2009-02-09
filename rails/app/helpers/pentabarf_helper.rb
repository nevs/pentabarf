module PentabarfHelper

  def rating_bar_small( rating, fields)
    xml = Builder::XmlMarkup.new
    xml.td(:class=>"rating-bar-small") do
      fields.each do | field |
        xml.span(:class=>"negative p#{case rating[field] when 1 then '2' when 2 then '1' else '0' end}")
        xml.br unless field == fields.last
      end
    end
    xml.td(:class=>"rating-bar-small") do
      fields.each do | field |
        xml.span(:class=>"positive p#{case rating[field] when 4 then '1' when 5 then '2' else '0' end}")
        xml.br unless field == fields.last
      end
    end
    xml
  end

  def event_rating_bar( rating )
    ratings = View_event_category_rating.select({:event_id=>rating.event_id,:person_id=>rating.person_id})
    xml = Builder::XmlMarkup.new
    xml.td(:class=>"rating-bar-small") do
      ratings.each do | r |
        xml.span(:title=>r.event_rating_category,:class=>"negative p#{case r.rating when 1 then '2' when 2 then '1' else '0' end}")
        xml.br unless r == ratings.last
      end
    end
    xml.td(:class=>"rating-bar-small") do
      ratings.each do | r |
        xml.span(:title=>r.event_rating_category,:class=>"positive p#{case r.rating when 4 then '1' when 5 then '2' else '0' end}")
        xml.br unless r == ratings.last
      end
    end
    xml
  end

end

