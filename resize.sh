if [ $# -lt 1 ]; then
    read -p "need parameter"
    exit
fi

echo $@

for f in $@; do
    brno=${f%/*}
    brno=${brno##*/}
    if [ ${brno} == ORIG ]; then 
        cp -v $f ${f/\//\/211\/}
        f=${f/\//\/211\/}
        brno=211
    fi
    fn=${f##*/}
    fn=${fn%.jpg}
    if [[ $fn != ${brno:1:2}* && $fn != 88* ]]; then
        mv -v $f ${f%/*}/${brno:1:2}$fn.jpg
        f=${f%/*}/${brno:1:2}$fn.jpg
    fi
    
    if [ -e ${f/#ORIG/100} ] ; then continue; fi

    echo converting $f
    magick convert $f -strip -resize "500x>" -write ${f/#ORIG/500} -resize "100x>" ${f/#ORIG/100} 

    git add $f ${f/#ORIG/500} ${f/#ORIG/100} 
done
