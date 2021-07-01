// Tests for Lab 10: Bit-Flip Error Correction
// Copyright 2021 The MITRE Corporation. All Rights Reserved.

namespace QSharpExercises.Tests.Lab10 {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Intrinsic;

    open QSharpExercises.Lab10;
    // open QSharpExercises.Solutions.Lab10;
    open QSharpExercises.Tests.Utils;


    @Test("QuantumSimulator")
    operation Exercise1Test () : Unit {
        for i in 1 .. 25 {
            use (original, spares) = (Qubit(), Qubit[2]);
            let rotation = GenerateRandomRotation();
            ApplyRotation(rotation, original);

            Exercise1(original, spares);

            CNOT(original, spares[0]);
            CNOT(original, spares[1]);
            Adjoint ApplyRotation(rotation, original);

            AssertAllZero([original] + spares);
        }
    }


    @Test("QuantumSimulator")
    operation Exercise2Test () : Unit {
        for i in 1 .. 10 {
            for brokenQubitIndex in -1 .. 3 {
                use register = Qubit[3];
                let rotation = GenerateRandomRotation();
                ApplyRotation(rotation, register[0]);
                Exercise1(register[0], register[1 .. 2]);

                // no error
                if (brokenQubitIndex == -1) {
                    mutable syndrome = Exercise2(register);
                    if syndrome[0] != Zero or syndrome[1] != Zero {
                        fail "Incorrect syndrome measurement. "
                           + "It should have been [Zero, Zero] but it was"
                           + $"[{syndrome[0]}, {syndrome[1]}";
                    }
                }

                // first qubit is flipped
                elif (brokenQubitIndex == 0) {
                    X(register[0]);
                    mutable syndrome = Exercise2(register);
                    if syndrome[0] != One or syndrome[1] != One {
                        fail "Incorrect syndrome measurement. "
                           + "It should have been [One, One] but it was"
                           + $"[{syndrome[0]}, {syndrome[1]}";
                    }
                }

                // second qubit is flipped
                elif (brokenQubitIndex == 1) {
                    X(register[1]);
                    mutable syndrome = Exercise2(register);
                    if syndrome[0] != One or syndrome[1] != Zero {
                        fail "Incorrect syndrome measurement. "
                           + "It should have been [One, Zero] but it was"
                           + $"[{syndrome[0]}, {syndrome[1]}";
                    }
                }

                // third qubit is flipped
                elif (brokenQubitIndex == 1) {
                    X(register[2]);
                    mutable syndrome = Exercise2(register);
                    if syndrome[0] != Zero or syndrome[1] != One {
                        fail "Incorrect syndrome measurement. "
                           + "It should have been [Zero, One] but it was"
                           + $"[{syndrome[0]}, {syndrome[1]}";
                    }
                }

                ResetAll(register);
            }
        }
    }


    @Test("QuantumSimulator")
    operation Exercise3Test () : Unit {
        for i in 1 .. 10 {
            for brokenQubitIndex in -1 .. 2 {
                use register = Qubit[3];
                let rotation = GenerateRandomRotation();
                ApplyRotation(rotation, register[0]);
                Exercise1(register[0], register[1 .. 2]);

                if brokenQubitIndex >= 0 {
                    X(register[brokenQubitIndex]);
                }

                let syndrome = Exercise2(register);

                Exercise3(register, syndrome);

                Adjoint Exercise1(register[0], register[1 .. 2]);
                Adjoint ApplyRotation(rotation, register[0]);

                AssertAllZero(register);
            }
        }
    }
}
