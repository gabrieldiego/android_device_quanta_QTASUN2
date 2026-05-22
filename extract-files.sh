#!/bin/bash
#
# Copyright (C) 2026 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0

set -e

DEVICE=QTASUN2
VENDOR=quanta

MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

if [ -z "${LINEAGE_ROOT}" ]; then
    LINEAGE_ROOT="${MY_DIR}/../../.."
fi

HELPER="${LINEAGE_ROOT}/vendor/lineage/build/tools/extract_utils.sh"
if [ ! -f "${HELPER}" ] && [ -d "${MY_DIR}/../../../lineage-17.1" ]; then
    LINEAGE_ROOT="${MY_DIR}/../../../lineage-17.1"
    HELPER="${LINEAGE_ROOT}/vendor/lineage/build/tools/extract_utils.sh"
fi

if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    echo "Set LINEAGE_ROOT=/path/to/lineage-17.1 and retry."
    exit 1
fi

source "${HELPER}"

CLEAN_VENDOR=true
SECTION=
KANG=

while [ "$1" != "" ]; do
    case "$1" in
        -n | --no-cleanup )
            CLEAN_VENDOR=false
            ;;
        -k | --kang )
            KANG="--kang"
            ;;
        -s | --section )
            shift
            SECTION="$1"
            CLEAN_VENDOR=false
            ;;
        * )
            SRC="$1"
            ;;
    esac
    shift
done

if [ -z "${SRC}" ]; then
    SRC=adb
fi

setup_vendor "${DEVICE}" "${VENDOR}" "${LINEAGE_ROOT}" false "${CLEAN_VENDOR}"

extract "${MY_DIR}/proprietary-files.txt" "${SRC}" ${KANG} --section "${SECTION}"

"${MY_DIR}/setup-makefiles.sh"
