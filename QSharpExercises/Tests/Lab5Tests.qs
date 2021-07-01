// Tests for Lab 5: Deutsch-Jozsa Algorithm
// Copyright 2021 The MITRE Corporation. All Rights Reserved.

namespace QSharpExercises.Tests.Lab5 {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Random;

    open QSharpExercises.Lab5;
    // open QSharpExercises.Solutions.Lab5;


    @Test("QuantumSimulator")
    operation Exercise1Test () : Unit {
        for i in 1 .. 100 {
            for numQubits in 3 .. 8 {
                use (inputQubits, target) = (Qubit[numQubits], Qubit());
                ApplyToEach(H, inputQubits);
                H(target);

                Exercise1(inputQubits, target);

                H(target);

                mutable numberOfOnes = 0;
                for qubit in inputQubits {
                    if M(qubit) == One {
                        set numberOfOnes += 1;
                        X(qubit);
                    }
                }

                let result = M(target);
                if result == One {
                    X(target);
                }

                if numberOfOnes % 2 == 0 and result != Zero {
                    fail "Measured even number of qubits in the |1> state, "
                       + "but target qubit was flipped.";
                }
                elif numberOfOnes % 2 == 1 and result != One {
                    fail "Measured odd number of qubits in the |1> state, "
                       + "but target qubit was not flipped.";
                }
            }
        }
    }


    @Test("QuantumSimulator")
    operation Exercise2Test () : Unit {
        for i in 1 .. 100 {
            for numQubits in 3 .. 8 {
                use (inputQubits, target) = (Qubit[numQubits], Qubit());
                let firstIndex = DrawRandomInt(0, numQubits - 1);
                let temp = DrawRandomInt(0, numQubits - 2);
                let secondIndex = firstIndex != temp ? temp | temp + 1;

                ApplyToEach(H, inputQubits);
                X(target);

                Exercise2(firstIndex, secondIndex, inputQubits, target);

                X(target);
                ApplyToEach(H, inputQubits);

                for index in 0 .. numQubits - 1 {
                    if index == firstIndex or index == secondIndex {
                        if M(inputQubits[index]) != One {
                            fail "Could not detect a parity check for the "
                               + "qubits at the specified indices.";
                        }
                        X(inputQubits[index]);
                    }
                    else {
                        if M(inputQubits[index]) != Zero {
                            fail "Qubits other that the ones at the specified "
                               + "indices were modified.";
                        }
                    }
                }
            }
        }
    }


    @Test("QuantumSimulator")
    operation Exercise3Test () : Unit {
        for i in 0..10 {
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
