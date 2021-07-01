// Lab 1: Single-Qubit Gates
// Copyright 2021 The MITRE Corporation. All Rights Reserved.

namespace QSharpExercises.Lab1 {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;

    /// # Summary
    /// In this exercise, you are given a single qubit which is in the |0>
    /// state. Your objective is to flip the qubit. Use the single-qubit
    /// quantum gates that Q# provides to transform it into the |1> state.
    ///
    /// # Input
    /// ## target
    /// The qubit you need to flip. It will be in the |0> state initially.
    ///
    /// # Remarks
    /// This will show you how to apply quantum gates to qubits in Q#.
    operation Exercise1 (target: Qubit) : Unit {
        // TODO
        fail "Not implemented.";
    }

    /// # Summary
    /// In this exercise, you are given two qubits. Both of them are in the |0>
    /// state. Using the single-qubit gates, turn them into the |+> state and 
    /// |-> state respectively.
    /// 
    /// Remember, the |+> state is 1/√2(|0> + |1>) and the |-> state is 
    /// 1/√2(|0> - |1>). If you need help figuring out how to do this, take a
    /// look at the Bloch Sphere and try to determine which gates you can use
    /// to rotate the qubit from one point to another.
    /// 
    /// # Input
    /// ## targetA
    /// Turn this qubit from |0> to |+>.
    /// 
    /// ## targetB
    /// Turn this qubit from |0> to |->.
    /// 
    /// # Remarks
    /// This should show you how to use single-qubit gates to put qubits into
    /// uniform quantum superpositions.
    operation Exercise2 (targetA : Qubit, targetB : Qubit) : Unit {
        // TODO
        fail "Not implemented.";
    }


    /// # Summary
    /// In this exercise, you have been given an array of qubits. The length
    /// of the array is a secret; you'll have to figure it out using Q#. The
    /// goal is to rotate each qubit around the Y axis by 15° (π/12 radians),
    /// multiplied by its index in the array.
    /// 
    /// For example: if the array had 3 qubits, you would need to leave the
    /// first one alone (index 0), rotate the next one by 15° (π/12 radians),
    /// and rotate the last one by 30° (2π/12 = π/6 radians).
    /// 
    /// # Input
    /// ## qubits
    /// The array of qubits you need to rotate.
    /// 
    /// # Remarks
    /// This will show you how work with arrays and for loops in Q#, and how
    /// to use the arbitrary rotation gates.
    operation Exercise3 (qubits : Qubit[]) : Unit {
        // Tip: you can get the value of π with the function PI().
        // Tip: you can use the IntAsDouble() function to cast an integer to
        // a double for floating-point arithmetic. Q# won't let you do arithmetic
        // between Doubles and Ints directly.

        // TODO
        fail "Not implemented.";
    }


    /// # Summary
    /// In this exercise, you have been given an array of qubits, the length of
    /// which is unknown again. Your goal is to measure each of the qubits, and
    /// construct an array of Ints based on the measurement results.
    /// 
    /// # Input
    /// ## qubits
    /// The qubits to measure. Each of them is in an unknown state.
    /// 
    /// # Output
    /// An array of Ints that has the same length as the input qubit array. Each
    /// element should be the measurement result of the corresponding qubit in the
    /// input array. For example: if you measure the first qubit to be Zero, then
    /// the first element of this array should be 0. If you measure the third qubit
    /// to be One, then the third element of this array should be 1.
    /// 
    /// # Remarks
    /// This will show you how to measure qubits, work with those measurements, and
    /// how to return things in Q# operations. It will also show you how to use
    /// if statements (or the ternary conditional operator, whatever you prefer).
    operation Exercise4 (qubits : Qubit[]) : Int[] {
        // Tip: you can either create the Int array with the full length directly
        // and update each of its values with the apply-and-replace operator, or
        // append each Int to the array as you go. Use whichever method you prefer.

        // TODO
        fail "Not implemented.";
    }
}
