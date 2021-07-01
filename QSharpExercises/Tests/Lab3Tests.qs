// Tests for Lab 3: Complex Superpositions
// Copyright 2021 The MITRE Corporation. All Rights Reserved.

namespace QSharpExercises.Tests.Lab3 {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;

    open QSharpExercises.Lab3;
    // open QSharpExercises.Solutions.Lab3;


    @Test("QuantumSimulator")
    operation Exercise1Test () : Unit {
        for numQubits in 1 .. 8 {
            use qubits = Qubit[numQubits];

            Exercise1(qubits);

            ApplyToEach(H, qubits);

            AssertAllZero(qubits);
        }
    }


    @Test("QuantumSimulator")
    operation Exercise2Test () : Unit {
        use (register, target) = (Qubit[3], Qubit());

        Exercise2(register, target);

        Controlled X(register, target);
        ApplyToEach(H, register);

        AssertAllZero(register + [target]);
    }


    @Test("QuantumSimulator")
    operation Exercise3Test () : Unit {
        use (register, target) = (Qubit[3], Qubit());

        Exercise3(register, target);
        
        ApplyToEach(X, register[0 .. 1]);
        Controlled X(register, target);
        ApplyToEach(X, register[0 .. 1]);
        ApplyToEach(H, register);

        AssertAllZero(register + [target]);
    }


    @Test("QuantumSimulator")
    operation Exercise4Test () : Unit {
        use qubits = Qubit[9];
        let registers = [
            qubits[0 .. 2],
            qubits[3 .. 5],
            qubits[6 .. 8]
        ];

        Exercise4(registers);

        Z(registers[0][2]);
        Z(registers[1][1]);
        Z(registers[2][0]);
        ApplyToEach(H, qubits);

        AssertAllZero(qubits);
    }


    @Test("QuantumSimulator")
    operation Exercise5Test () : Unit {
        use register = Qubit[3];

        Exercise5(register);

        X(register[2]);
        use ancilla = Qubit() {
            X(ancilla);
            Controlled Z(register, ancilla);
            X(ancilla);
        }
        X(register[2]);
        ApplyToEach(H, register);

        AssertAllZero(register);
    }


    @Test("QuantumSimulator")
    operation Exercise6Test () : Unit {
        use register = Qubit[2];

        Exercise6(register);

        Controlled H([register[0]], register[1]);
        H(register[0]);

        AssertAllZero(register);
    }


    @Test("QuantumSimulator")
    operation Exercise7Test () : Unit {
        use register = Qubit[3];

        Exercise7(register);

        ApplyToEach(X, register[1 .. 2]);
        use ancilla = Qubit() {
            X(ancilla);
            Controlled Z(register, ancilla);
            X(ancilla);
        }
        ApplyToEach(X, register[1 .. 2]);
        CNOT(register[1], register[2]);
        Controlled H([register[0]], register[1]);
        H(register[0]);

        AssertAllZero(register);
    }


    @Test("QuantumSimulator")
    operation Challenge1Test () : Unit {
        use qubits = Qubit[2];

        Challenge1(qubits);

        X(qubits[0]);
        Controlled H([qubits[0]], qubits[1]);
        X(qubits[0]);

        let desiredProbability = 2.0 / 3.0;
        let angle = 2.0 * ArcCos(Sqrt(desiredProbability));
        Ry(-angle, qubits[0]);

        AssertAllZero(qubits);
    }


    @Test("QuantumSimulator")
    operation Challenge2Test () : Unit {
        use qubits = Qubit[3];

        Challenge2(qubits);

        X(qubits[0]);
        CNOT(qubits[0], qubits[2]);
        CNOT(qubits[1], qubits[2]);
        Controlled H([qubits[0]], qubits[1]);
        X(qubits[0]);

        let desiredProbability = 2.0 / 3.0;
        let angle = 2.0 * ArcCos(Sqrt(desiredProbability));
        Ry(-angle, qubits[0]);

        AssertAllZero(qubits);
    }


    @Test("QuantumSimulator")
    operation Challenge3Test () : Unit {
        use qubits = Qubit[3];

        Challenge3(qubits);

        X(qubits[2]);
        CNOT(qubits[2], qubits[1]);
        X(qubits[2]);
        Controlled H([qubits[2]], qubits[1]);
        H(qubits[2]);
        H(qubits[0]);
        X(qubits[0]);

        AssertAllZero(qubits);
    }


    @Test("QuantumSimulator")
    operation Challenge4Test () : Unit {
        use qubits = Qubit[3];

        Challenge4(qubits);

        CCNOT(qubits[2], qubits[0], qubits[1]);
        Controlled H([qubits[2]], qubits[1]);
        Controlled X([qubits[2]], qubits[1]);
        H(qubits[0]);
        X(qubits[2]);
        CNOT(qubits[2], qubits[0]);
        X(qubits[2]);
        H(qubits[2]);

        AssertAllZero(qubits);
    }
}
