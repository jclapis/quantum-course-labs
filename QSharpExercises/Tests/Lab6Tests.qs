// Tests for Lab 6: Grover's Algorithm
// Copyright 2021 The MITRE Corporation. All Rights Reserved.

namespace QSharpExercises.Tests.Lab6 {

    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Random;

    open QSharpExercises.Lab6;
    // open QSharpExercises.Solutions.Lab6;
    open QSharpExercises.Tests.Utils;


    @Test("QuantumSimulator")
    operation Exercise1Test () : Unit {
        let testCases = [
            [false, true, true],
            [true, false, true, true],
            [true, true, false, true, false],
            [false, false, true, true, false, true],
            [true, true, true, true, false, true, true],
            [true, true, true, true, true, true, true, true],
            [true, false, false, true, true, false, false, true, true],
            [true, false, true, true, false, true, false, true, true, false]
        ];

        for testCase in testCases {
            let length = Length(testCase);
            use qubits = Qubit[length];

            mutable randomState = new Bool[0];
            for i in 0 .. length - 1 {
                set randomState += [DrawRandomBool(0.5)];
                if randomState[i] {
                    X(qubits[i]);
                }
            }

            Exercise1(testCase, qubits);

            for i in 0 .. length - 1 {
                EqualityFactB(
                    ResultAsBool(M(qubits[i])),
                    testCase[i] != randomState[i],
                    $"Incorrect result for {testCase[i]} XOR {randomState[i]}"
                );
            }

            ResetAll(qubits);
        }

        // Ensure qubits are not being measured
        use qubit = Qubit();
        let rotation = GenerateRandomRotation();
        ApplyRotation(rotation, qubit);

        Exercise1([true], [qubit]);

        X(qubit);
        Adjoint ApplyRotation(rotation, qubit);

        AssertAllZero([qubit]);
    }

    @Test("QuantumSimulator")
    operation Exercise2Test () : Unit {
        for i in 0 .. 50 {
            for numQubits in 3 .. 8 {
                use (qubits, target) = (Qubit[numQubits], Qubit());
                ApplyToEach(H, qubits + [target]);

                Exercise2(qubits, target);

                H(target);

                mutable isAllZero = true;
                for qubit in qubits {
                    if M(qubit) == One {
                        set isAllZero = false;
                    }
                }

                EqualityFactB(
                    M(target) == One,
                    isAllZero,
                    "AllZeros test failed"
                );

                ResetAll(qubits + [target]);
            }
        }

        // Ensure qubits are not being measured
        use (qubit, target) = (Qubit(), Qubit());
        let rotation = GenerateRandomRotation();
        ApplyRotation(rotation, qubit);
        H(target);

        Exercise2([qubit], target);

        X(qubit);
        Controlled Z([qubit], target);
        X(qubit);
        Adjoint ApplyRotation(rotation, qubit);
        H(target);

        AssertAllZero([qubit] + [target]);
    }

    @Test("QuantumSimulator")
    operation Exercise3Test () : Unit {
        for i in 1 .. 10 {
            for numQubits in 3 .. 8 {
                mutable original = new Bool[0];
                mutable key = new Bool[0];
                mutable encrypted = new Bool[0];
                for j in 0 .. numQubits - 1 {
                    set original += [DrawRandomBool(0.5)];
                    set key += [DrawRandomBool(0.5)];
                    set encrypted += [original[j] != key[j]];
                }

                use (qubits, target) = (Qubit[numQubits], Qubit());

                mutable randomRotations = new Double[][0];
                for j in 0 .. numQubits - 1 {
                    set randomRotations += [GenerateRandomRotation()];
                    ApplyRotation(randomRotations[i], qubits[i]);
                }
                H(target);

                Exercise3(original, encrypted, qubits, target);

                Exercise1(original, qubits);
                Exercise1(encrypted, qubits);
                Exercise2(qubits, target);
                Exercise1(original, qubits);
                Exercise1(encrypted, qubits);
                H(target);

                for j in 0 .. numQubits - 1 {
                    Adjoint ApplyRotation(randomRotations[i], qubits[i]);
                }

                AssertAllZero(qubits + [target]);
            }
        }

        // Ensure qubits are not being measured
        use (qubit, target) = (Qubit(), Qubit());
        let rotation = GenerateRandomRotation();
        ApplyRotation(rotation, qubit);
        H(target);

        Exercise3([true], [true], [qubit], target);

        X(qubit);
        Controlled Z([qubit], target);
        X(qubit);
        Adjoint ApplyRotation(rotation, qubit);
        H(target);

        AssertAllZero([qubit] + [target]);
    }

    @Test("QuantumSimulator")
    operation Exercise4GroverIterationTest () : Unit {
        for i in 1 .. 25 {
            for numQubits in 3 .. 8 {
                mutable original = new Bool[0];
                mutable key = new Bool[0];
                mutable encrypted = new Bool[0];
                for j in 0 .. numQubits - 1 {
                    set original += [DrawRandomBool(0.5)];
                    set key += [DrawRandomBool(0.5)];
                    set encrypted += [original[j] != key[j]];
                }

                use (qubits, target) = (Qubit[numQubits], Qubit());
                ApplyToEach(H, qubits);
                X(target);

                Exercise4(
                    Exercise3(original, encrypted, _, _),
                    qubits,
                    target
                );

                ApplyToEach(H, qubits);
                Exercise2(qubits, target);
                ApplyToEach(H, qubits);

                Exercise3(original, encrypted, qubits, target);
                X(target);
                ApplyToEach(H, qubits);

                AssertAllZero(qubits + [target]);
            }
        }
    }

    operation BoolArrayAsString (boolArray : Bool[]) : String {
        mutable str = "";
        for i in 0 .. Length(boolArray) - 1 {
            set str += boolArray[i] ? "1" | "0";
            if i % 8 == 7 {
                set str += " ";
            }
        }
        return str;
    }

    @Test("QuantumSimulator")
    operation Exercise5GroverSearchTest () : Unit {
        for numQubits in 10 .. 14 {
            mutable original = new Bool[0];
            mutable key = new Bool[0];
            mutable encrypted = new Bool[0];
            for j in 0 .. numQubits - 1 {
                set original += [DrawRandomBool(0.5)];
                set key += [DrawRandomBool(0.5)];
                set encrypted += [original[j] != key[j]];
            }

            Message($"Running Grover search on {numQubits} qubits.");
            Message($"Original = {BoolArrayAsString(original)}");
            Message($"Encrypted = {BoolArrayAsString(encrypted)}");

            for i in 1 .. 5 {
                let result = Exercise5(
                    Exercise3(original, encrypted, _, _),
                    numQubits
                );

                Message($"Search returned {BoolArrayAsString(result)}");

                mutable foundCorrectKey = true;
                for j in 0 .. numQubits - 1 {
                    if result[j] != key[j] {
                        set foundCorrectKey = false;
                    }
                }
                if (foundCorrectKey) {
                    Message("Got the right key!");
                    return ();
                } else {
                    Message("Incorrect key, trying again...");
                }
            }
        }
    }
}
