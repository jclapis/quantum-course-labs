// Lab 2: Multi-Qubit Gates
// Copyright 2021 The MITRE Corporation. All Rights Reserved.

namespace QSharpExercises.Lab2 {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;


    /// # Summary
    /// In this exercise, you are given two qubits. Both qubits are in
    /// arbitrary, unknown states:
    /// 
    ///     |QubitA> = a|0> + b|1>
    ///     |QubitB> = c|0> + d|1>
    /// 
    /// Use the two-qubit gates in Q# to switch their amplitudes, so
    /// this is the end result:
    /// 
    ///     |QubitA> = c|0> + d|1>
    ///     |QubitB> = a|0> + b|1>
    /// 
    /// # Input
    /// ## qubitA
    /// The first qubit, which starts in the state a|0> + b|1>.
    /// 
    /// ## qubitB
    /// The second qubit, which starts in the state c|0> + d|1>.
    /// 
    /// # Remarks
    /// This will show you how to apply quantum gates that take more than one
    /// qubit.
    operation Exercise1 (qubitA : Qubit, qubitB : Qubit) : Unit {
        // Hint: you can do this with a single statement, using one gate.

        // TODO
        fail "Not implemented.";
    }


    /// # Summary
    /// In this exercise, you're given a register of qubits with unknown
    /// length. Each qubit is in an arbitrary, unknown state. Your goal
    /// is to reverse the register, so the order of qubits is reversed.
    /// 
    /// For example, if the register had 3 qubits where:
    ///
    ///     |Q0> = a|0> + b|1>
    ///     |Q1> = c|0> + d|1>
    ///     |Q2> = e|0> + f|1>
    /// 
    /// Your goal would be to modify the qubits in the register so that
    /// the qubit's states are reversed:
    /// 
    ///     |Q0> = e|0> + f|1>
    ///     |Q1> = c|0> + d|1>
    ///     |Q2> = a|0> + b|1>
    /// 
    /// Note that the register itself is immutable, so you can't just reorder
    /// the elements like you would in a classical array. In other words, the
    /// first element of the array will always be Q0 and the last element will
    /// always be Q(n-1) - you can't set the first element to Q(n-1) and the
    /// last element to Q0. You must reverse the register by reversing the states
    /// of the qubits themselves, without changing the actual order of the qubits
    /// in the register.
    /// 
    /// # Input
    /// ## register
    /// The qubit register that you need to reverse.
    /// 
    /// # Remarks
    /// This will test your combined knowledge of arrays and multi-qubit gates.
    operation Exercise2 (register : Qubit[]) : Unit {
        // TODO
        fail "Not implemented.";
    }


    /// # Summary
    /// In this exercise, you are given an array of qubit registers. There are
    /// four registers in the array, and each register contains two qubits. All
    /// eight qubits will be in the |0> state, so each register is in the state
    /// |00>.
    /// 
    /// Your goal is to put the four registers into these four states:
    /// 
    ///     Register 0 = 1/√2(|00> + |11>)
    ///     Register 1 = 1/√2(|00> - |11>)
    ///     Register 2 = 1/√2(|01> + |10>)
    ///     Register 3 = 1/√2(|01> - |10>)
    /// 
    /// These four states are known as the Bell States. They are the simplest
    /// examples of full entanglement between two qubits.
    /// 
    /// # Input
    /// ## registers
    /// An array of four two-qubit registers. All of the qubits are in the |0>
    /// state.
    /// 
    /// # Remarks
    /// This will show you how to call quantum operations from other quantum
    /// operations. It will also test your understanding of how register
    /// superposition notation corresponds to the effects that quantum gates
    /// have on qubits.
    operation Exercise3 (registers : Qubit[][]) : Unit {
        // Hint: you can start by putting all four registers into the state
        // 1/√2(|00> + |11>), then build the final state for each register 
        // from there.

        // TODO
        fail "Not implemented.";
    }


    /// # Summary
    /// In this exercise, you are given a qubit register of unknown length.
    /// All of the qubits in it are in the |0> state, so the whole register
    /// is in the state |0...0>.
    /// 
    /// Your task is to transform this register into this state:
    /// 
    ///     |register> = 1/√2(|0...0> + |1...1>)
    /// 
    /// For example, if the register had 5 qubits, you would need to put it
    /// in the state 1/√2(|00000> + |11111>). These states are called the
    /// GHZ states.
    /// 
    /// # Input
    /// ## register
    /// The qubit register. It is in the state |0...0>.
    /// 
    /// # Remarks
    /// This will test your understanding of the relationships between entangled
    /// qubits in a register by making you apply your knowledge to a register
    /// with more than two qubits.
    operation Exercise4 (register : Qubit[]) : Unit {
        // TODO
        fail "Not implemented.";
    }


    /// # Summary
    /// In this exercise, you are given a qubit register of length four. All of
    /// its qubits are in the |0> state initially, so the whole register is in
    /// the state |0000>.
    /// Your goal is to put it into the following state:
    /// 
    ///     |register> = 1/√2(|0101> - |0110>)
    /// 
    /// You will need to use the H, X, Z, and CNOT gates to achieve this.
    /// 
    /// # Input
    /// ## register
    /// The qubit register. It is in the state |00000>.
    operation Exercise5 (register : Qubit[]) : Unit {
        // TODO
        fail "Not implemented.";
    }
}
