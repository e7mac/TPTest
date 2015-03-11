require 'github_api'


def BranchExistsOnRepo(repo, target_branch)
  github = Github.new basic_auth: 'tidepooladmin:t1d3p00l'
  repo = github.repos :user => 'tidepool', :repo => repo
  repo.branches do |branch|
    if branch.name == target_branch
      return true
    end
  end
  return false
end

def GetCommitMessagesForRepo(repo, target_branch)
  github = Github.new basic_auth: 'tidepooladmin:t1d3p00l'  
  commits = github.repos.commits.all  'tidepool', repo
  commits.each do |commit|
    # puts commit
# sha
# commit
# url
# html_url
# comments_url
# author
# committer
# parents
# -----------
    commit = commit.commit
# author
# committer
# message
# tree
# url
# comment_count
# -----------
    puts commit.message
  end
end

# HashieMash
# pr.each_pair do |k,v|
#   puts k
# end

def MergeRepoBranchToBaseForAppStore(repo, head, base)
  title = 'App Store PR made at ' + Time.now.strftime("%a %B %d, %Y at %I:%M %p %Z")
  MergeRepoBranchToBase(repo, head, base, title)
  tag = 'v0.1'
  AddTagToLatestCommit(repo, 'master', tag, title)
end

def MergeRepoBranchToBase(repo, head, base, title)
  github = Github.new basic_auth: 'tidepooladmin:t1d3p00l'
  begin
    github.pull_requests.create 'tidepool', repo, title: title, head: head, base: base
  rescue
    puts 'PR exists'
  end
  # puts github.pull_requests.actions
  prs = github.pull_requests.all 'tidepool', repo
  prs.each do |pr|
    if pr.merged? == false and pr.base.ref == base and pr.head.ref == head
      github.pull_requests.merge 'tidepool', repo, pr.number
    end
  end
end

def AddTagToLatestCommit(repo, branch, tag, message)
  github = Github.new basic_auth: 'tidepooladmin:t1d3p00l'  
  commits = github.repos.commits.all  'tidepool', repo
  commit = commits.first
  t = github.git_data.tags.create 'tidepool', repo,
        tag: tag,
        message: message,
        type: "commit",
        object: commit.sha
  github.git_data.references.create 'tidepool', repo,
    ref: "refs/tags/" + t.tag,
    sha: t.sha

end