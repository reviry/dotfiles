#! /bin/sh

for source in "$@"; do
    case $source in
	*ChangeLog|*changelog)
        source-highlight --failsafe -f esc --lang-def=changelog.lang --style-file=$HOME/.source-highlight/esc-solarized.style -i "$source" ;;
	*Makefile|*makefile)
        source-highlight --failsafe -f esc --lang-def=makefile.lang --style-file=$HOME/.source-highlight/esc-solarized.style -i "$source" ;;
	*.tar|*.tgz|*.gz|*.bz2|*.xz)
        lesspipe "$source" ;;
        *) source-highlight --failsafe --infer-lang -f esc --style-file=$HOME/.source-highlight/esc-solarized.style -i "$source" ;;
    esac
done
