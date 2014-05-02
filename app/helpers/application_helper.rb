module ApplicationHelper

  def title(text)
    content_for :title do
      "#{text} - "
    end
  end

  def avatar_for(user, size: 40)
    retina_size = size * 2
    url = user.avatar_url + {s: retina_size}.to_query
    image_tag url, height: size, width: size, class: 'avatar'
  end
end
