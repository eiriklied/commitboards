module CommitsHelper
  def link_to_project(commit)
    link_to_if(commit.github_path.present?,
               commit.project, github_project_url(commit),
               target: '_blank', rel: 'new' )
  end

  def link_to_commit_with_message(commit)
    msg = truncate(commit.message)
    if commit.github_path.present?
      link_to github_commit_url(commit), target: '_blank', rel: 'new', title: commit.message do
        truncate(commit.message) + ' <span class="glyphicon glyphicon-share-alt"/>'.html_safe
      end
    else
      msg
    end
  end

  def github_project_url(commit)
    "https://github.com/#{commit.github_path}"
  end

  def github_commit_url(commit)
    "#{github_project_url(commit)}/commit/#{commit.sha}"
  end
end
