""" Allow cross-execution targeting Android devices.

Test module to execute a benchmark through adb on a connected Android
device. This assumes all relevant directories and files are present on the remote
device."""

import logging
import os
import subprocess

from litsupport import testplan


def mutatePlan(context, plan):
    # serial number of the device
    if hasattr(context.config, "remote_host") and context.config.remote_host != "":
        remote_host = "-s " + context.config.remote_host
    else:
        remote_host = ""

    # the path to load libc++_shared.so
    extra_lib_loc = "LD_LIBRARY_PATH=" + context.config.android_run_under

    # Prepend `adb [-s remote_host] shell` in front of each command.
    # Prepend LD_LIBRARY_PATH to resolve libc++_shared.so.
    def make_adb_command(s_in):
        s_out = 'adb {} shell "{} {}"'.format(remote_host, extra_lib_loc, s_in)
        return s_out

    plan.preparescript = [make_adb_command(script) for script in plan.preparescript]
    plan.runscript = [make_adb_command(script) for script in plan.runscript]
    plan.verifyscript = [make_adb_command(script) for script in plan.verifyscript]

    # Create output directory if nonexist.
    plan.preparescript.append(
        "adb {} shell mkdir -p {}".format(remote_host, context.tmpDir)
    )

    # Replace the host-side path in the commands with
    # device-side path.
    toreplace_str = context.config.test_source_root
    replacement_str = os.path.join(
        context.config.android_run_under,
        os.path.split(context.config.test_source_root)[1],
    )

    plan.preparescript = [
        script.replace(toreplace_str, replacement_str) for script in plan.preparescript
    ]
    plan.runscript = [
        script.replace(toreplace_str, replacement_str) for script in plan.runscript
    ]
    plan.verifyscript = [
        script.replace(toreplace_str, replacement_str) for script in plan.verifyscript
    ]

    # adb pull timeit time files.
    if hasattr(context, "timefiles"):
        for timefile in context.timefiles:
            plan.profilescript.append(
                "adb {} pull {} {}".format(
                    remote_host,
                    timefile.replace(toreplace_str, replacement_str),
                    timefile,
                )
            )
