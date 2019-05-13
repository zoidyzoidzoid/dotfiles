export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

function kubectl-diff () {
    icdiff <(kubectl get -f $1 -o json | jq '.status={}' | jy) $1
}
