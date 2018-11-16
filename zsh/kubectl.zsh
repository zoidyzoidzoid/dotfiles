alias k="kubectl"

alias kgp="kubectl get po"
alias kks="kubectl -n kube-system"
alias kksgp="kubectl -n kube-system get po"

# pipenv () {
#     if ! typeset -f _pipenv > /dev/null
#     then
#         eval "$(command pipenv --completion)"
#     fi
#     command pipenv "$@"
#     unfunction pipenv
# }
