set -e

filename=$1
dir=`pwd`
ln -s $dir/$filename ~/.$filename
