# Copyright 2021 The MITRE Corporation. All Rights Reserved.

# This file provides a workaround for a problem where Visual Studio's unit
# test runner doesn't properly get its environment variables set when it
# activates a conda environment to run a unit test. This means it misses
# a lot of additional directories in the PATH variable that are specific
# to the conda environment; for example, PATH won't have 
# "C:\Users\<username>\.conda\envs\<env_name>\Library\bin", which is where
# a lot of the DLLs for Qiskit's Aer simulators live. Without this path,
# the unit test runner won't load Aer properly.

import sys
import os

 # Get the directory of the currently-running python executable, which should
 # be the conda environment directory
env_dir = os.path.dirname(sys.executable)

# Append "\\Library\\bin" to the end of the environment directory
lib_dir = os.path.join(env_dir, "Library", "bin")

# Add this to the system's PATH variable, so the test runner will know where
# to look for Aer's DLLs
os.environ["PATH"] += ";" + lib_dir
