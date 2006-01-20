module PentabarfHelper

  def process_conflicts( conflicts, processed_conflicts )
    conflicts.each do | c |
      conflict = {}
      if c.class == Momomoto::View_conflict_person
        conflict[:img] = url_for({:controller=>'image',:action=>:person,:id=>c.person_id}) + "-24x24"
        conflict[:url] = url_for({:action=>:person,:id=>c.person_id})
        conflict[:who] = link_to(h(c.name), {:action=>:person,:id=>c.person_id}) 
      elsif c.class == Momomoto::View_conflict_event
        conflict[:img] = url_for({:controller=>'image',:action=>:event,:id=>c.event_id}) + "-24x24"
        conflict[:url] = url_for({:action=>:event,:id=>c.event_id})
        conflict[:who] = link_to(h(c.title), {:action=>:event,:id=>c.event_id}) 
      elsif c.class == Momomoto::View_conflict_event_person
        conflict[:img] = url_for({:controller=>'image',:action=>:person,:id=>c.person_id}) + "-24x24"
        conflict[:url] = url_for({:action=>:person,:id=>c.person_id})
        conflict[:who] = link_to(h(c.name), {:action=>:person,:id=>c.person_id}) + "<br/>"
        conflict[:who] += link_to(h(c.title), {:action=>:event,:id=>c.event_id}) 
      elsif c.class == Momomoto::View_conflict_event_person_event
        conflict[:img] = url_for({:controller=>'image',:action=>:person,:id=>c.person_id}) + "-24x24"
        conflict[:url] = url_for({:action=>:person,:id=>c.person_id})
        conflict[:who] = link_to(h(c.name), {:action=>:person,:id=>c.person_id}) + "<br/>" 
        conflict[:who] += link_to(h(c.title1), {:action=>:event,:id=>c.event_id1}) + "<br/>"
        conflict[:who] += link_to(h(c.title2), {:action=>:event,:id=>c.event_id2}) 
      elsif c.class == Momomoto::View_conflict_event_event
        conflict[:img] = url_for({:controller=>'image',:action=>:event,:id=>c.event_id1}) + "-24x24"
        conflict[:url] = url_for({:action=>:event,:id=>c.event_id1})
        conflict[:who] = link_to(h(c.title1), {:action=>:event,:id=>c.event_id1}) + "<br/>"
        conflict[:who] += link_to(h(c.title2), {:action=>:event,:id=>c.event_id2}) 
      else
        raise "Unknown class #{c.class} in process_conflicts"
      end
      conflict[:level_tag] = c.level_tag
      conflict[:level] = c.level_name
      conflict[:desc] = c.conflict_name
      processed_conflicts.push( conflict )
    end 
  end

  def rating_bar( ratings, field )
    count, sum = 0, 0
    for rating in ratings
      next if rating[field].to_i == 0
      count += 1
      sum += ( rating[field].to_i - 3 )
    end
    if count > 0
      average = ( ( sum * 5 ) / count ).to_i * 10
      v_pos = average >= 0 ? average : nil
      v_neg = average < 0 ? average : nil
    else
      v_pos, v_neg = 0, nil
    end
    
    html = '<td class="rating-bar">'
    html += "<span class=\"negative p#{ v_neg ? v_neg.abs : '0'}\">#{ v_neg }</span>"
    html += '</td>'
    html += '<td class="rating-bar">'
    html += "<span class=\"positive p#{ v_pos ? v_pos : '0'}\">#{ v_pos }</span>"
    html += '</td>'
    html += "<td>#{count.to_i}</td>"
    html
  end

  def rating_bar_small( rating, fields)
    html = '' 
    html += '<td class="rating-bar-small">'
    fields.each do | field |
      html += "<span class=\"negative p#{ case rating[field] when 1 then '2' when 2 then '1' else '0' end }\"></span><br/>"
    end
    html += '</td>'
    html += '<td class="rating-bar-small">'
    fields.each do | field |
      html += "<span class=\"positive p#{ case rating[field] when 4 then '1' when 5 then '2' else '0' end }\"></span><br/>"
    end
    html += '</td>'
    html
  end

  def pagination( total, hits_per_page, current_page )
    html = ''
    (total.to_f/hits_per_page.to_f).ceil.times do | i | 
      html += "<button type=\"button\" class=\"#{ i == current_page ? 'active' : ''}\" onclick=\"new Ajax.Updater('results', '#{ url_for(:id => i) }');\">"
      html += (i * hits_per_page + 1).to_s
      html += "&#x2026;"
      html += (((i + 1) * hits_per_page) > total ? total : (i + 1) * hits_per_page).to_s
      html += "</button> "
    end
    html
  end

end
