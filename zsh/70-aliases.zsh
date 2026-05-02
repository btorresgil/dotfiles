# Aliases

alias gi='git-ignore'

if command -v eza 1>/dev/null 2>&1; then
  alias ls="eza --git"
  alias lsl="eza --git --long --icons=auto --group"
  alias lss="eza --git --color=always --long --no-filesize --icons=always --no-time --no-user --no-permissions"
fi
command -v bat >/dev/null && alias cat='bat'
command -v prettyping >/dev/null && alias ping='prettyping --nolegend'
alias ncdu='ncdu --color dark -x --exclude .git --exclude node_modules'
alias preview="fzf --preview 'bat --color \"always\" {}'"
alias flushdns="sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder"

alias bw-unlock='export BW_SESSION=`bw unlock --raw`'

alias urldecode='python -c "import sys, urllib.parse as ul; \
    print(ul.unquote_plus(sys.argv[1]))"'
alias urlencode='python -c "import sys, urllib.parse as ul; \
    print(ul.quote_plus(sys.argv[1]))"'

alias gh-browse='gh repo view --web'
alias zshtime='for i in $(seq 1 10); do /usr/bin/time zsh -i -c exit; done'
alias k='kubectl'

# doppler aliases
alias d='doppler'
alias dr='doppler run --'
alias dc='f() { doppler run --command=''$1'' };f'
alias dcx='f() { doppler run -p "$1" --command=''$2'' };f'
alias ds='doppler secrets'
alias dss='doppler secrets set'
alias dsr='f() { doppler secrets set ''$2''="$(doppler secrets get ''$1'' --plain)"; doppler secrets delete ''$1'' -y --silent };f'
alias tf='doppler run --name-transformer tf-var -- terraform'
alias tg='doppler run --name-transformer tf-var -- terragrunt'

# docker-compose aliases
alias dcu='docker-compose up -d --remove-orphans'
alias dcr='docker-compose restart'
alias dcdown='docker-compose down --remove-orphans'
alias dcl='docker-compose logs --tail=300'
alias dce='docker-compose exec'
alias dcps='docker-compose ps'
alias dcp='docker-compose pull'

# SSH aliases
alias sshproxy='ssh -o ProxyCommand="nc -X 5 -x 127.0.0.1:1080 %h %p"'
alias sshdirect='ssh -o ProxyCommand=""'
alias splunkaws='ssh -i ~/.ssh/AmazonKeyPair.pem ec2-user@splunk-aws.panw.biz'
alias oasis='ssh oasis'
alias splunk='gcloud compute --project "ixius-splunk" ssh --zone "us-west1-b" "splunk@splunk"'

function seecert () {
  nslookup $1
  (openssl s_client -showcerts -servername $1 -connect $1:443 <<< "Q" | openssl x509 -text | grep -iA2 "Validity")
}
