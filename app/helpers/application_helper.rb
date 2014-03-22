module ApplicationHelper

  def title(text)
    content_for :title do
      "#{text} - "
    end
  end
end
