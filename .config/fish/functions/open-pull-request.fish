function open-pull-request
  set merge_commit (ruby -e 'print (File.readlines(ARGV[0]) & File.readlines(ARGV[1])).last' (git rev-list --ancestry-path $argv..master|psub) (git rev-list --first-parent $argv..master|psub))
  if git show $merge_commit | grep -q 'pull request'
    set repo_url (gh browse -n)
    set pull_request_number (git log -1 --format=%B $merge_commit | sed -e 's/^.*#\([0-9]*\).*$/\1/' | head -1)
    set url "$repo_url/pull/$pull_request_number"
  end
  gh pr view --comments $pull_request_number
end

