// Tests for Lab 1: Single-Qubit Gates
// Copyright 2021 The MITRE Corporation. All Rights Reserved.

namespace QSharpExercises.Tests.Lab1 {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Random;

    open QSharpExercises.Lab1;
    // open QSharpExercises.Solutions.Lab1;


    @Test("QuantumSimulator")
    operation Exercise1Test () : Unit {
        use target = Qubit();

        Exercise1(target);

        X(target);

        AssertQubit(Zero, target);
    }


    @Test("QuantumSimulator")
    operation Exercise2Test () : Unit {
        use targets = Qubit[2];

        Exercise2(targets[0], targets[1]);

        H(targets[0]);
        H(targets[1]);
        X(targets[1]);

        AssertAllZero(targets);
    }


    @Test("QuantumSimulator")
    operation Exercise3Test () : Unit {
        for numQubits in 3 .. 10 {
            use qubits = Qubit[numQubits];

            Exercise3(qubits);

            for index in 0 .. numQubits - 1 {
                Ry(PI() * IntAsDouble(index) / -12.0, qubits[index]);
            }

            AssertAllZero(qubits);
        }
    }


    @Test("QuantumSimulator")
    operation Exercise4Test () : Unit {
        for i in 0 .. 4 {
            mutable states = new Int[0];
            use qubits = Qubit[5];
            for j in 0 .. 4 {
                set states += [DrawRandomInt(0, 1)];
                if states[j] == 1 {
                    X(qubits[j]);
                }
            }

            let results = Exercise4(qubits);

            AllEqualityFactI(states, results, "Exercise 4 test failed.");
            ResetAll(qubits);
        }
    }
}
