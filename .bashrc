# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# User specific aliases and functions
#parse_git_branch() {
#            git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
#}

function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}
# User specific aliases and functions
export PS1='\[\e[41m\] \u @ \H | \[\e[7m\] $PWD \[\e[0m\] \[\e[0m\] $(parse_git_branch) \[\033[00m\]\[\033[00m\] \n $ \[\e[0m\]'

SSHAGENT=/usr/bin/ssh-agent
SSHAGENTARGS="-s"
if [ -z "$SSH_AUTH_SOCK" -a -x "$SSHAGENT" ]; then
  eval `$SSHAGENT $SSHAGENTARGS` > /dev/null
  trap "kill $SSH_AGENT_PID" 0 > /dev/null
fi


alias j="jobs"
alias ss="sudo /sbin/service "
alias ls="ls --color=auto"

_ssh_auth_save() {
 ln -sf "$SSH_AUTH_SOCK" "$HOME/.screen/ssh-auth-sock.$HOSTNAME"
}
alias screen='_ssh_auth_save ; export HOSTNAME=$(hostname) ; screen'
alias style='jake dev:style'
