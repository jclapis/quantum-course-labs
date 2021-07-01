// Tests for Lab 11: Steane's Error Correction Code
// Copyright 2021 The MITRE Corporation. All Rights Reserved.

namespace QSharpExercises.Tests.Lab11 {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Intrinsic;

    open QSharpExercises.Lab11;
    // open QSharpExercises.Solutions.Lab11;
    open QSharpExercises.Tests.Utils;


    @Test("QuantumSimulator")
    operation Exercise1EncodeTest () : Unit {
        use (original, spares) = (Qubit(), Qubit[6]);

        for i in 1 .. 10 {
            let rotation = GenerateRandomRotation();
            ApplyRotation(rotation, original);

            Exercise1(original, spares);

            ApplyToEach(CNOT(spares[3], _), spares[0 .. 2]);
            ApplyToEach(CNOT(spares[4], _), [original] + spares[1 .. 2]);
            ApplyToEach(CNOT(spares[5], _), [original, spares[0], spares[2]]);
            ApplyToEach(CNOT(original, _), spares[0 .. 1]);
            ApplyToEach(H, spares[3 .. 5]);

            Adjoint ApplyRotation(rotation, original);

            AssertAllZero([original] + spares);
        }
    }


    @Test("QuantumSimulator")
    operation Exercise2BitFlipSyndromeTest () : Unit {
        use qubits =  Qubit[7];

        for i in 1 .. 10 {
            for brokenIndex in -1 .. 6 {
                let rotation = GenerateRandomRotation();
                ApplyRotation(rotation, qubits[0]);

                Exercise1(qubits[0], qubits[1 .. 6]);

                if brokenIndex >= 0 {
                    X(qubits[brokenIndex]);
                }

                let syndrome = Exercise2(qubits);

                if ((brokenIndex + 1) &&& 0b100) == 0b100 {
                    EqualityFactR(
                        One,
                        syndrome[0],
                        "Bit-flip syndrome measurment 0 is incorrect"
                    );
                }
                if ((brokenIndex + 1) &&& 0b010) == 0b010 {
                    EqualityFactR(
                        One,
                        syndrome[1],
                        "Bit-flip syndrome measurement 1 is incorrect"
                    );
                }
                if ((brokenIndex + 1) &&& 0b001) == 0b001 {
                    EqualityFactR(
                        One,
                        syndrome[2],
                        "Bit-flip syndrome measurement 2 is incorrect"
                    );
                }

                ResetAll(qubits);
            }
        }
    }


    @Test("QuantumSimulator")
    operation Exercise3PhaseFlipSyndromeTest () : Unit {
        use qubits = Qubit[7];

        for i in 1 .. 10 {
            for brokenIndex in -1 .. 6 {
                let rotation = GenerateRandomRotation();
                ApplyRotation(rotation, qubits[0]);

                Exercise1(qubits[0], qubits[1 .. 6]);

                if brokenIndex >= 0 {
                    Z(qubits[brokenIndex]);
                }

                let syndrome = Exercise3(qubits);

                if ((brokenIndex + 1) &&& 0b100) == 0b100 {
                    EqualityFactR(
                        One,
                        syndrome[0],
                        "Phase-flip syndrome measurment 0 is incorrect"
                    );
                }
                if ((brokenIndex + 1) &&& 0b010) == 0b010 {
                    EqualityFactR(
                        One,
                        syndrome[1],
                        "Phase-flip syndrome measurement 1 is incorrect"
                    );
                }
                if ((brokenIndex + 1) &&& 0b001) == 0b001 {
                    EqualityFactR(
                        One,
                        syndrome[2],
                        "Phase-flip syndrome measurement 2 is incorrect"
                    );
                }

                ResetAll(qubits);
            }
        }
    }


    @Test("QuantumSimulator")
    operation Exercise4BrokenIndexTest () : Unit {
        for brokenIndex in -1 .. 6 {
            let syndrome = [
                ((brokenIndex + 1) &&& 0b100) == 0b100 ? One | Zero,
                ((brokenIndex + 1) &&& 0b010) == 0b010 ? One | Zero,
                ((brokenIndex + 1) &&& 0b001) == 0b001 ? One | Zero
            ];
            EqualityFactI(
                brokenIndex,
                Exercise4(syndrome),
                $"Incorrect broken index for syndrome {syndrome}"
            );
        }
    }


    @Test("QuantumSimulator")
    operation Exercise5CorrectErrorsTest () : Unit {
        use qubits = Qubit[7];

        for i in 1 .. 10 {
            for bitFlipIndex in -1 .. 6 {
                for phaseFlipIndex in -1 .. 6 {
                    let rotation = GenerateRandomRotation();
                    ApplyRotation(rotation, qubits[0]);

                    Exercise1(qubits[0], qubits[1 .. 6]);

                    if bitFlipIndex >= 0 {
                        X(qubits[bitFlipIndex]);
                    }

                    if phaseFlipIndex >= 0 {
                        Z(qubits[phaseFlipIndex]);
                    }

                    Exercise5(qubits);

                    Adjoint Exercise1(qubits[0], qubits[1 .. 6]);
                    Adjoint ApplyRotation(rotation, qubits[0]);

                    AssertAllZero(qubits);
                }
            }
        }
    }
}
