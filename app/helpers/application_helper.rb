module ApplicationHelper

  def title(text)
    content_for :title do
      "#{text} - "
    end
  end

  def avatar_for(user)
    image_tag user.avatar_url
  end
end
