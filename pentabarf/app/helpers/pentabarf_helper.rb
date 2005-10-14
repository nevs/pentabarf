module PentabarfHelper

  def process_conflicts( conflicts, processed_conflicts )
    conflicts.each do
      conflict = {}
      conflict[:img] = url_for({:controller=>'image',:action=>:person,:id=>conflicts.person_id})
      conflict[:url] = url_for({:action=>:person,:id=>conflicts.person_id})
      conflict[:level_tag] = conflicts.level_tag
      conflict[:level] = conflicts.level_name
      conflict[:desc] = conflicts.conflict_name
      conflict[:who] = link_to(h(conflicts.name), {:action=>:person,:id=>conflicts.person_id}) 
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

  def pagination( total, hits_per_page, current_page )
    html = ''
    (total.to_f/hits_per_page.to_f).ceil.times do | i | 
      html += "<button type=\"button\" class=\"#{ i == current_page ? 'active' : ''}\" onclick=\"b = new Ajax.Updater('results', '#{ url_for(:id => i) }');b.updateContent();\">"
      html += (i * hits_per_page + 1).to_s
      html += "&#x2026;"
      html += (((i + 1) * hits_per_page) > total ? total : (i + 1) * hits_per_page).to_s
      html += "</button> "
    end
    html
  end

end
