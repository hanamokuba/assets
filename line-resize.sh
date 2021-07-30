if [ $# -lt 1 ]; then
    echo need parameter;
    exit
fi

echo "$@"
crd="$(pwd)"

for f in $@; do
    echo $f
    fp=${f%.jpg}
    # echo ${brno:1:2}
    mkdir -p $fp 
    mv -v $f $fp/1040
    echo converting $fp/
    cd $fp
    magick convert 1040 -strip -resize "700x>" -write 700 -resize "460x>" -write 460 -resize "300x>" -write 300 -resize "240x>" 240
    cd $crd
    git add $fp/*
    cp -v $fp/1040 $fp/1040.jpg
done