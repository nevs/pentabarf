module PentabarfHelper

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

end
