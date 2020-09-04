#!/bin/bash

#
# Copyright (2020) Open Devices GmbH
# Copyright (2020) Djalal Harouni
#


declare RUNTIME_ARGS="$@"

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin


# Mark update bad and rollback
mark_update_bad() {

        return  # no exit
}

check_exit_status() {
        local exit_code=$?
        if [ $exit_code -ne 0 ]; then
                echo "Error: check update status: [failed]"
                mark_update_bad
        else
                echo "Info: check update status: [succeeded]"
        fi

        exit $exit_code
}

check_failed_units() {
        out=$(systemctl --failed --all 2>/dev/null)
        if [[ $out != *"0 loaded units"* ]]; then
                echo "Error: check system units failed; update will be aborted"
                exit 1
        fi
}

check_rauc_status() {
        return
}

main() {

        trap check_exit_status EXIT

        check_failed_units

        check_rauc_status

        exit 0
}

main $RUNTIME_ARGS
