#!/usr/bin/env bash

FZF_DEFAULT_OPTS="--reverse --height 30%  --header 'Choose markdown file'"

CACHE_DIR=$HOME/.hack/

function check_prerequisite() {
  local prerequisites=(curl mdless jq fzf)
  for tool in ${prerequisites[@]}; do
    type ${tool} >/dev/null 2>&1 || { echo >&2 "I require $tool but it's not installed."; exit 1; }
  done
}

function select_md_file() {
  local github_repo=${1}
  curl -s https://api.github.com/repos/${github_repo}/contents | \
  jq -r '.[].name | select(endswith(".md"))' | \
  fzf
}

function download_md_file() {
  local remote_url=$1
  local local_file_location=$2
  curl -L -s ${remote_url} | sed -e '/^{: /d' > ${local_file_location}
}

function main() {
  check_prerequisite 

  if [[ "${1}" = "local" ]]; then
    local selected_local_cache_file=$(find ${CACHE_DIR} -type file | fzf)
    mdless ${selected_local_cache_file} 2>/dev/null
  else
    local github_repo=${1:-rstacruz/cheatsheets}
    local selected_md_file=$(select_md_file ${github_repo})
    local repo_cache_dir=${CACHE_DIR}/${github_repo}

    if [ ! -d ${repo_cache_dir} ]; then
      mkdir -p ${repo_cache_dir}
    fi

    local local_cache_file=${repo_cache_dir}/${selected_md_file}
    local raw_md_file="https://raw.github.com/${github_repo}/master/${selected_md_file}"
    download_md_file ${raw_md_file} ${local_cache_file}
    mdless $local_cache_file 2>/dev/null
  fi
}

main $@
