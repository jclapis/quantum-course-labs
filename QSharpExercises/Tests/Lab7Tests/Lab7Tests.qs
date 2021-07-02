// Tests for Lab 7: Simon's Algorithm
// Copyright 2021 The MITRE Corporation. All Rights Reserved.

namespace QSharpExercises.Tests.Lab7 {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Random;

    open QSharpExercises.Lab7;
    // open QSharpExercises.Solutions.Lab7;


    @Test("QuantumSimulator")
    operation Exercise1Test () : Unit {
        for numQubits in 3 .. 10 {
            mutable randomInput = new Bool[0];
            for i in 1 .. numQubits {
                set randomInput += [DrawRandomBool(0.5)];
            }

            let copyOutput = Exercise1(Copy, randomInput);
            AllEqualityFactB(
                copyOutput,
                randomInput,
                "Incorrect output for Copy operation"
            );

            let shiftOutput = Exercise1(LeftShiftBy1, randomInput);
            let expected = randomInput[1...] + [false];
            AllEqualityFactB(
                shiftOutput,
                expected,
                "Incorrect output for LeftShiftBy1 operation"
            );
        }
    }
}
