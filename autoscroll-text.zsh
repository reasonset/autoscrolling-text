#!/usr/bin/zsh

typeset SCRIPT_VERSION="0.0.1"

typeset rendered_file="/tmp/$$-autoscroll-text.html"
typeset url="$rendered_file"
typeset add_header_file="/tmp/$$-autoscroll-text-header.html"
typeset pandoc_template_file="/tmp/$$-autoscroll-text-template.html"
typeset bodyclass="default"

typeset -i markdown_mode=0
typeset -i barepath_mode=0

usage() {
    print "Usage: $0 [-m] sourcefile" >&2
    exit 1
}

while getopts "mhvb:c:" opt
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
  c)
    if [[ $OPTARG == *[/\"\&\<\>]* ]]
    then
      print "You cannot use /, &, <, > or \" for classname."
      exit 1
    fi
    typeset bodyclass="$OPTARG"
    ;;
  b)
    typeset autoscroll_text_overide_browser="$OPTARG"
    ;;
  p)
    barepath_mode=1
    ;;
  esac
done

shift $((OPTIND - 1))

if [[ -z $1 ]]
then
  usage
fi

if (( barepath_mode != 1 ))
then
  url="file://$rendered_file"
fi

typeset sourcefile="$1"

######## GENERATE #########

if (( markdown_mode == 1 ))
then
  #Generate script loader
  cat <<EOF > $add_header_file
  <script src="file://${XDG_CONFIG_HOME:-$HOME/.config}/autoscroll-text/scrollingtext.js"></script>
EOF

  # Generate template
  pandoc -D html5 | sed 's/<body>/<body class="$bodyclass$">/' > $pandoc_template_file
  # Markdown mode
  pandoc -t html5 -s -c "file://"${XDG_CONFIG_HOME:-$HOME/.config}/autoscroll-text/scrollingtext.css -M "bodyclass=${bodyclass}" -H $add_header_file --template="$pandoc_template_file" $sourcefile > $rendered_file
  rm $add_header_file $pandoc_template_file
else
  # Plain mode

  cat > $rendered_file <<EOF
<html>
  <head>
    <title>${sourcefile:t} Auto-scrolling Text</title>
    <link rel="stylesheet" href="file://${XDG_CONFIG_HOME:-$HOME/.config}/autoscroll-text/scrollingtext.css" />
  </head>
  <body class="${bodyclass}">
    <article><pre class="line-block" style="white-space:pre-wrap;">$(sed 's/&/&amp;/g' $sourcefile | sed -e 's/</&lt;/g' -e 's/>/&gt;/g')</pre></article>
    <script src="file://${XDG_CONFIG_HOME:-$HOME/.config}/autoscroll-text/scrollingtext.js"></script>
  </body>
</html>
EOF

fi

######## Render ############

#BGM
if [[ -e "{$XDG_CONFIG_HOME:-$HOME/.config}/autoscroll-text/BGM" ]]
then
  mpv --loop-playlist=inf "{$XDG_CONFIG_HOME:-$HOME/.config}/autoscroll-text/BGM"
  typeset -i bgmpid=$!
fi

#SHOW
${autoscroll_text_overide_browser:-surf} $url

#Stop BGM
if [[ -n $bgmpid ]]
then
  kill $bgmpid
fi

#Remove temporary file
rm $rendered_file
