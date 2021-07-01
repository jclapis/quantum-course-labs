// Lab 10: Bit-Flip Error Correction
// Copyright 2021 The MITRE Corporation. All Rights Reserved.

namespace QSharpExercises.Lab10 {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;


    /// # Summary
    /// In this exercise, you are provided with an original qubit in an
    /// unknown state a|0> + b|1>. You are also provided with two blank
    /// qubits, both of which are in the |0> state. Your goal is to construct
    /// a "logical qubit" from these three qubits that acts like a single
    /// qubit, but can protect against bit-flip errors on any one of the three
    /// actual qubits.
    /// 
    /// To construct the logical qubit, put the three qubits into the
    /// entangled state a|000> + b|111>.
    /// 
    /// # Input
    /// ## original
    /// A qubit that you want to protect from bit flips. It will be in the
    /// state a|0> + b|1>.
    /// 
    /// ## spares
    /// A register of two spare qubits that you can use to add error
    /// correction to the original qubit. Both are in the |0> state.
    operation Exercise1 (original : Qubit, spares : Qubit[]) : Unit is Adj {
        // Note the "Unit is Adj" - this is special Q# syntax that lets the
        // compiler automatically generate the adjoint (inverse) version of
        // this operation, so it can just be run backwards to decode the
        // logical qubit back into the original three unentangled qubits.

        // TODO
        fail "Not implemented.";
    }


    /// # Summary
    /// In this exercise, you are provided with a logical qubit, represented
    /// by an error-protected register that was encoded with your Exercise 1
    /// implementation. Your goal is to perform a syndrome measurement on the
    /// register. This should consist of two parity checks (a parity check is
    /// an operation to see whether or not two qubits have the same state).
    /// The first parity check should be between qubits 0 and 1, and the 
    /// second check should be between qubits 0 and 2.
    /// 
    /// # Input
    /// ## register
    /// A three-qubit register representing a single error-protected logical
    /// qubit. Its state is unknown, and one of the qubits may have suffered
    /// a bit flip error.
    /// 
    /// # Output
    /// An array of two measurement results. The first result should be the
    /// measurement of the parity check on qubits 0 and 1, and the second
    /// result should be the measurement of the parity check on qubits 0 and
    /// 2. If both qubits in a parity check have the same state, the resulting
    /// bit should be Zero. If the two qubits have different states (meaning
    /// one of the two qubits was flipped), the result should be One.
    operation Exercise2 (register : Qubit[]) : Result[] {
        // Hint: You will need to allocate an ancilla qubit for this. You can
        // do it with only one ancilla qubit, but you can allocate two if it
        // makes things easier. Don't forget to reset the qubits you allocate
        // back to the |0> state!

        // TODO
        fail "Not implemented.";
    }


    /// # Summary
    /// In this exercise, you are provided with a logical qubit encoded with
    /// your Exercise 1 implementation and a syndrome measurement array
    /// produced by your Exercise 2 implementation. Your goal is to interpret
    /// the syndrome measurement to find which qubit in the error-corrected
    /// register suffered a bit-flip error (if any), and to correct it by
    /// flipping it back to the proper state.
    /// 
    /// # Input
    /// ## register
    /// A three-qubit register representing a single error-protected logical
    /// qubit. Its state is unknown, and one of the qubits may have suffered
    /// a bit flip error.
    /// 
    /// ## syndromeMeasurement
    /// An array of two measurement results that represent parity checks. The
    /// first one represents a parity check between qubit 0 and qubit 1; if
    /// both qubits have the same parity, the result will be 0, and if they
    /// have opposite parity, the result will be One. The second result
    /// corresponds to a parity check between qubit 0 and qubit 2.
    operation Exercise3 (
        register : Qubit[],
        syndromeMeasurement : Result[]
    ) : Unit {
        // Tip: you can use the Message() operation to print a debug message
        // out to the console. You might want to consider printing the index
        // of the qubit you identified as broken to help with debugging.

        // TODO
        fail "Not implemented.";
    }
}
