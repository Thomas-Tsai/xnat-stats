#!/usr/bin/python3.5
# -*- coding: utf-8 -*-

import os
import pydicom
import sys


if __name__ == '__main__':
    dFile=sys.argv[1]
    dicom_file = pydicom.read_file(dFile)
    try:
        frames = int(dicom_file[0x28,0x08].value)
    except:
        if "PixelData" in dicom_file:
            frames = "1"
        else:
            frames = "0"
    try:
        slices = int(dicom_file[0x54,0x81].value)
    except:
        if "PixelData" in dicom_file:
            slices = "1"
        else:
            slices = "0"
    print("{0}, {1}".format(frames, slices))
