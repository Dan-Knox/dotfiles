#! /usr/bin/env zsh
set -o nounset
set -o errexit

#source this from file ~/.profile, or paste the following there

git(){
    case "$PWD" in
        ${HOME}/evident/*)
            export GIT_AUTHOR_NAME="Dan Knox"
            export GIT_AUTHOR_EMAIL="dknox@evident.io"
            export GIT_COMMITTER_NAME="Dan Knox"
            export GIT_COMMITTER_EMAIL="dknox@evident.io"
            ;;
        *)
            export GIT_AUTHOR_NAME="Dan Knox"
            export GIT_AUTHOR_EMAIL="dknox@threedotloft.com"
            export GIT_COMMITTER_NAME="Dan Knox"
            export GIT_COMMITTER_EMAIL="dknox@threedotloft.com"
            ;;
    esac
    command git "$@"
}
