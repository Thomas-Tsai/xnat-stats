#!/bin/bash
xnat_path_arch="/home/partimag/dev/xnat/dmxnat_local"
dicomimg="/home/partimag/dev/xnat/calimgs.py"
logs="/home/partimag/dev/xnat/logs"

checkdicom(){
    OIFS="$IFS"
    IFS=$'\n'

    pro=$1
    logfile="$logs/$pro.log"
    echo `date` > $logfile
    files=$(find $pro)
    for tfile in $files; do
        isdicom=$(file $tfile | grep -i 'DICOM M')
	if [[ ! -z "${isdicom// }" ]]; then
	    count=$(python3 $dicomimg "$tfile")
	    echo $pro, $tfile, $count >> $logfile
	fi
    done
    echo `date` >> $logfile
    IFS="$OIFS"
}

pushd $xnat_path_arch

pros="CAG chest3 CVAI Fracture glaucoma metastases normal PCV PCV_partial SPECT tmu_CA_CT_lesi tmu_CA_CT_lesion tmu_CCTA_CT_lesion tmu_chestCT_im tmu_chestXray tmu_LCACT_full tmu_lca_dev tmu_lungCACTse v1_BT_meningio v1_chest v1_chest2 v1_CV_PV v1_ENT v1_HCC v1_mSASSS v1_mSASSS_AS v1_mSASSS_L v1_mTSS v1_mTSS_H v1_mTSS_RA v1_ORTHO V1TEST vs"
pros="normal glaucoma"

for pro in $pros; do
    checkdicom $pro &
    done
popd
