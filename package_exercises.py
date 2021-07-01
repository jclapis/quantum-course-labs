# Script to package the course exercises in a .zip file
# Copyright 2021 The MITRE Corporation. All Rights Reserved.

import errno
import glob
import os
import shutil

INCLUDES = [
    'Intro to Quantum Software Development.sln',
    'global.json',
    'CSharpExercises/CSharpExercises.csproj',
    'CSharpExercises/Exercises.cs',
    'CSharpExercises/Tests.cs',
    'QSharpExercises/QSharpExercises.csproj',
    'QSharpExercises/*.qs',
    'QSharpExercises/Tests/*',
    'ConsoleSandbox/*'
]

for path in INCLUDES:
    for src in glob.glob(path):
        dst = 'tmp/' + src
        os.makedirs(os.path.dirname(dst), exist_ok=True)
        try:
            shutil.copytree(src, dst)
        except OSError as exc:
            if exc.errno == errno.ENOTDIR:
                shutil.copy(src, dst)
            else: raise

shutil.make_archive('exercises', 'zip', 'tmp')
shutil.rmtree('tmp')
