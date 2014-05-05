namespace :emoji do

  desc 'Put all known emojis into a js array for awesome autcomplete using at.js'
  task :generate_js => :environment do
    emoji_keywords_as_js_strings = Emoji.names.map{|e| "'#{e}'"}
    js = %{
window.emojis = [#{emoji_keywords_as_js_strings.join(',')}];
    }

    File.write "#{Rails.root}/vendor/assets/javascripts/emojis.js", js
  end
end
