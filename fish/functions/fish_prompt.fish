function _git_branch_name
  echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function _git_is_dirty
  echo (command git status -s --ignore-submodules=dirty ^/dev/null)
end

function fish_prompt
  set -l cyan (set_color cyan)
  set -l yellow (set_color yellow)
  set -l red (set_color red)
  set -l blue (set_color blue)
  set -l green (set_color green)
  set -l normal (set_color normal)

  set -l user_and_host $blue (whoami)@(hostname|cut -d . -f 1)
  set -l short_path $green (basename (prompt_pwd))
  set -l end_symbol $red '∴'

  # Show git branch and status
  if [ (_git_branch_name) ]
    set -l git_branch (_git_branch_name)

    if [ (_git_is_dirty) ]
      set git_info $yellow "($git_branch±)"
    else
      set git_info $green "($git_branch)"
    end
  end

  # Terminate with a nice prompt char
  echo -e "$user_and_host$short_path$git_info$end_symbol" $normal
end