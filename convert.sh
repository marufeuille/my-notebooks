#!/bin/bash

function get_category {
  echo "$(ls notebooks)"
}

function convert {
  cats=$1
  for cat in $cats
  do
    mkdir -p docs/${cat}
    jupyter nbconvert --to html --output-dir docs/${cat} notebooks/${cat}/*
  done
}

function get_filename {
  filename=$1
  echo $filename | cut -d . -f 1
}

function make_summary {
  cats=$1

  cat << __EOS__
<!doctype html>
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@exampledev/new.css@1/new.min.css">
<title>notebooks</title>
</head>
<body>
<h1>My Notebooks</h1>
__EOS__

  for cat in $cats
  do
    echo "<h2>${cat}</h2>"
    echo "<ul>"
    for file_with_ext in $(ls notebooks/${cat})
    do
      filename=$(get_filename $file_with_ext)
      echo "<li><a href='./${cat}/${filename}.html'>${filename}</a></li>"
    done
    echo "</ul>"
  done
  cat << __EOS__
</body>
</html>
__EOS__

}

function main {
  cats=$(get_category)
  convert "$cats"
  make_summary "$cats"
}

main "$#"
