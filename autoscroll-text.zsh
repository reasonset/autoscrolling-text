#!/usr/bin/zsh

typeset SCRIPT_VERSION="0.0.1"

typeset rendered_file="/tmp/$$-autoscroll-text.html"
typeset add_header_file="/tmp/$$-autoscroll-text-header.html"

typeset -i markdown_mode=0

usage() {
    print "Usage: $0 [-m] sourcefile" >&2
    exit 1
}

while getopts "mhvb:" opt
do
  case $opt in
  m)
    markdown_mode=1
    ;;
  h)
    usage
    ;;
  v)
    print "Autoscroll Text $SCRIPT_VERSION"
    print "© 2018 Masaki Haruka."
    print "This program licensed under MIT License."
    exit
    ;;
  b)
    print "COME"
    typeset autoscroll_text_overide_browser="$OPTARG"
    ;;
  esac
done

shift $((OPTIND - 1))

if [[ -z $1 ]]
then
  usage
fi

typeset sourcefile="$1"

#Generate script loader
cat <<EOF > $add_header_file
<script src="file://${XDG_CONFIG_HOME:-$HOME/.config}/autoscroll-text/scrollingtext.js"></script>
EOF


######## GENERATE #########

if (( markdown_mode == 1 ))
then
  # Markdown mode
  pandoc -t html5 -s -c "file://"${XDG_CONFIG_HOME:-$HOME/.config}/autoscroll-text/autoscroll-text.css -H $add_header_file $sourcefile > $rendered_file
else
  # Plainmode
  typeset temporary_markdown_file="/tmp/$$-autoscroll-text.md"
  sed -e 's/^/| /' -e 's/[<>]/\\&/g' $sourcefile > $temporary_markdown_file # Convert all to line-blocks
  pandoc -t html5 -M "title=${sourcefile:t}" -s -c "file://"${XDG_CONFIG_HOME:-$HOME/.config}/autoscroll-text/scrollingtext.css -H $add_header_file $temporary_markdown_file > $rendered_file
fi

######## Render ############

#BGM
if [[ -e "{$XDG_CONFIG_HOME:-$HOME/.config}/autoscroll-text/BGM" ]]
then
  mpv --loop-playlist=inf "{$XDG_CONFIG_HOME:-$HOME/.config}/autoscroll-text/BGM"
  typeset -i bgmpid=$!
fi

#SHOW
${autoscroll_text_overide_browser:-surf} $rendered_file

#Stop BGM
if [[ -n $bgmpid ]]
then
  kill $bgmpid
fi

#Remove temporary file
[[ -n $temporary_markdown_file ]] && [[ -e $temporary_markdown_file ]] && rm $temporary_markdown_file
rm $rendered_file $add_header_file
