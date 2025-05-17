alias dc=cd
alias grpe=grep
alias gr=rg
alias cls=clear

alias ls="eza --all --long"
alias ll="eza --all --long --group"
alias lt="eza --tree"
alias lg="eza --all --long --git"

alias psmem="ps -ax --sort -%mem --format=%mem,ucmd,rss,pid | head -11 | awk 'NR==1{print \"%MEM:CMD:MEM:PID\"; next} {printf \"%s:%s:%.2f MB:%s\n\", \$1, \$2, \$3/1024, \$4}' | column -s ':' -t"
alias pscpu="ps -ax --sort -%cpu --format=%cpu,ucmd,pid | column -t | head -11"
