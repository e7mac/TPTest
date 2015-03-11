require_relative 'github_helper'

repos = [
  'TPTest',
]

for repo in repos
  puts repo
  MergeRepoBranchToBaseForAppStore(repo, 'development', 'master')
end

