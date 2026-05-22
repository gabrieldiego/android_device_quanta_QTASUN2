#!/bin/bash
#
# Copyright (C) 2026 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0

set -e

DEVICE=QTASUN2
VENDOR=quanta

INITIAL_COPYRIGHT_YEAR=2026

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

. "${HELPER}"

setup_vendor "${DEVICE}" "${VENDOR}" "${LINEAGE_ROOT}"

write_headers
write_makefiles "${MY_DIR}/proprietary-files.txt"
write_footers
