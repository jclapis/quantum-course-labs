// Lab 4: Superdense Coding
// Copyright 2021 The MITRE Corporation. All Rights Reserved.

namespace QSharpExercises.Lab4 {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Intrinsic;


    /// # Summary
    /// In this exercise, you will take on the role of the "sender" in the
    /// superdense coding protocol. You will encode a classical message into a
    /// pair of entangled qubits. The system has already entangled the two
    /// qubits together into the 1/√2(|00> + |11>) state and sent one of the
    /// qubits to the remote receiver. You are given a classical buffer with
    /// two bits in it, and the other remaining qubit. Your goal is to encode
    /// both of the classical bits into the entangled qubit pair using only
    /// single-qubit gates on the provided "sender" qubit.
    /// 
    /// # Input
    /// ## buffer
    /// An array of two classical bits, where false represents 0, and true
    /// represents 1.
    /// 
    /// ## pairA
    /// A qubit that is entangled with another qubit in the state
    /// 1/√2(|00> + |11>).
    operation Exercise1 (buffer : Bool[], pairA : Qubit) : Unit {
        // TODO
        fail "Not implemented.";
    }


    /// # Summary
    /// In this exercise, you will take on the role of the "receiver" in the
    /// superdense coding protocol. The sender has sent a pair of entangled
    /// qubits to you and encoded two bits of classical data in them. The
    /// system has received the two qubits, and has presented them here for
    /// you to process. The state of the qubits is unknown, but it should be
    /// in one of the states that you created with your encoding operation
    /// above. Your goal is to recover the two classical bits that are encoded
    /// in the qubits, and return them in a classical buffer.
    /// 
    /// # Input
    /// ## pairA
    /// One of the qubits in the entangled pair.
    /// 
    /// ## pairB
    /// The other qubit in the entangled pair.
    /// 
    /// # Output
    /// A classical bit array containing the two bits that were encoded in the
    /// entangled pair. Use false for 0 and true for 1.
    operation Exercise2 (pairA : Qubit, pairB : Qubit) : Bool[] {
        // TODO
        fail "Not implemented.";
    }
}
