#!/bin/bash
xnat_path_arch="/home/partimag/dev/xnat/dmxnat"
dicomimg="/home/partimag/dev/xnat/calimgs.py"
pushd $xnat_path_arch

pros=$(ls)

for pro in $pros; do
    #echo $pro
    files=$(find $pro)
    for tfile in $files; do
        isdicom=$(file $tfile | grep -i 'DICOM M')
	if [[ ! -z "${isdicom// }" ]]; then
	    count=$(python3 $dicomimg $tfile)
	    echo $pro, $tfile, $count
	fi
    done
done
popd
