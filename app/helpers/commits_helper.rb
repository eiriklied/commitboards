module CommitsHelper
  def link_to_project(commit)
    link_to_if(commit.github_path.present?,
               commit.project, github_project_url(commit),
               target: '_blank', rel: 'new' )
  end

  def link_to_commit_with_message(commit)
    link_to_if(commit.github_path.present?,
               truncate(commit.message), github_commit_url(commit),
               target: '_blank', rel: 'new', title: commit.message )
  end

  def github_project_url(commit)
    "https://github.com/#{commit.github_path}"
  end

  def github_commit_url(commit)
    "#{github_project_url(commit)}/commit/#{commit.sha}"
  end
end
