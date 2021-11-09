for f in `find . -type d`; do echo "MD $f"; done | sed 's/\.\//\/' | tr '/' '\'
