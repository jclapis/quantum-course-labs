// Tests for Lab 2: Multi-Qubit Gates
// Copyright 2021 The MITRE Corporation. All Rights Reserved.

namespace QSharpExercises.Tests.Lab2 {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Intrinsic;

    open QSharpExercises.Lab2;
    // open QSharpExercises.Solutions.Lab2;
    open QSharpExercises.Tests.Utils;


    @Test("QuantumSimulator")
    operation Exercise1Test () : Unit {
        for i in 0 .. 4 {
            use qubits = Qubit[2];
            let rotations = [
                GenerateRandomRotation(),
                GenerateRandomRotation()
            ];

            ApplyRotation(rotations[0], qubits[0]);
            ApplyRotation(rotations[1], qubits[1]);

            Exercise1(qubits[0], qubits[1]);

            Adjoint ApplyRotation(rotations[0], qubits[1]);
            Adjoint ApplyRotation(rotations[1], qubits[0]);

            AssertAllZero(qubits);
        }
    }


    @Test("QuantumSimulator")
    operation Exercise2Test () : Unit {
        for numQubits in 3 .. 8 {
            use register = Qubit[numQubits];
            mutable rotations = new Double[][0];
            for index in 0 .. numQubits - 1 {
                set rotations += [GenerateRandomRotation()];
                ApplyRotation(rotations[index], register[index]);
            }

            Exercise2(register);

            for index in 0 .. numQubits - 1 {
                Adjoint ApplyRotation(
                    rotations[numQubits - index - 1],
                    register[index]
                );
            }

            AssertAllZero(register);
        }
    }


    @Test("QuantumSimulator")
    operation Exercise3Test () : Unit {
        use qubits = Qubit[8];
        let registers = [
            [qubits[0], qubits[1]],
            [qubits[2], qubits[3]],
            [qubits[4], qubits[5]],
            [qubits[6], qubits[7]]
        ];

        Exercise3(registers);

        for register in registers {
            CNOT(register[0], register[1]);
            H(register[0]);
        }

        // now, register 0 should be |00>,
        //      register 1 should be |10>,
        //      register 2 should be |01>, and
        //      register 3 should be |11>
        X(registers[1][0]);
        X(registers[2][1]);
        X(registers[3][0]);
        X(registers[3][1]);

        AssertAllZero(qubits);
    }


    @Test("QuantumSimulator")
    operation Exercise4Test () : Unit {
        for numQubits in 2 .. 10 {
            use register = Qubit[numQubits];

            Exercise4(register);

            for index in 1 .. numQubits - 1 {
                CNOT(register[0], register[index]);
            }
            H(register[0]);

            AssertAllZero(register);
        }
    }


    @Test("QuantumSimulator")
    operation Exercise5Test () : Unit {
        use register = Qubit[4];

        Exercise5(register);

        Z(register[2]);
        X(register[3]);
        CNOT(register[2], register[3]);
        H(register[2]);
        X(register[1]);

        AssertAllZero(register);
    }
}
