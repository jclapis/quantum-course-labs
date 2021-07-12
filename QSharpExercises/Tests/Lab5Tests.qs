// Tests for Lab 5: Deutsch-Jozsa Algorithm
// Copyright 2021 The MITRE Corporation. All Rights Reserved.

namespace QSharpExercises.Tests.Lab5 {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Random;

    // open QSharpExercises.Lab5;
    open QSharpExercises.Solutions.Lab5;


    @Test("QuantumSimulator")
    operation Exercise1Test () : Unit {
        for numQubits in 3 .. 8 {
            use (input, output) = (Qubit[numQubits], Qubit());
            ApplyToEach(H, input);
            X(output);

            Exercise1(input, output);

            for qubit in input {
              Controlled Z([qubit], output);
            }
            X(output);
            ApplyToEach(H, input);

            AssertAllZero(input + [output]);
        }
    }


    @Test("QuantumSimulator")
    operation Exercise2Test () : Unit {
        for i in 1 .. 10 {
            for numQubits in 3 .. 8 {
                use (input, output) = (Qubit[numQubits], Qubit());
                let firstIndex = DrawRandomInt(0, numQubits - 1);
                let temp = DrawRandomInt(0, numQubits - 2);
                let secondIndex = firstIndex != temp ? temp | temp + 1;

                ApplyToEach(H, input);
                X(output);

                Exercise2(firstIndex, secondIndex, input, output);

                Controlled Z([input[firstIndex]], output);
                Controlled Z([input[secondIndex]], output);
                X(output);
                ApplyToEach(H, input);

                AssertAllZero(input + [output]);
            }
        }
    }


    @Test("QuantumSimulator")
    operation Exercise3Test () : Unit {
        for i in 0 .. 10 {
            for numQubits in 3 .. 8 {
                let firstIndex = DrawRandomInt(0, numQubits - 1);
                    let temp = DrawRandomInt(0, numQubits - 2);
                    let secondIndex = firstIndex != temp ? temp | temp + 1;

                if Exercise3(numQubits, AlwaysZero) == false {
                    fail "Incorrectly classified AlwaysZero as balanced.";
                }

                if Exercise3(numQubits, AlwaysOne) == false {
                    fail "Incorrectly classified AlwaysOne as balanced.";
                }

                if Exercise3(numQubits, Exercise1) == true {
                    fail "Incorrectly classified Exercise1 as constant.";
                }

                if Exercise3(
                    numQubits,
                    Exercise2(firstIndex, secondIndex, _, _)
                ) == true {
                    fail "Incorrectly classified Exercise2 as constant.";
                }
            }
	    }
    }
}
