# SealOS Update status - check update

Checks status of SealOS updates, then commits results and rollbacks in case.

How it works:

1. sealos-update-check-no-failures.service will run before boot-complete.target that is the synchronization point for
services that shall determine if boot completed successfully. If this service succeeds then boot-complete.target will be
reached, if not then boot is considered failed.

2. rauc-mark-good.service if the boot-complete.target is reached and boot is considered good then rauc-mark-good will
run and commit current slot.
