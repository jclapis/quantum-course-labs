# Copyright 2021 The MITRE Corporation. All Rights Reserved.


from qiskit import QuantumCircuit, ClassicalRegister, QuantumRegister
from qiskit import execute
from qiskit import Aer
from qiskit import IBMQ
from qiskit.compiler import transpile
from time import perf_counter


# This file provides a short reference that shows typical operations in Qiskit,
# such as building circuits, executing them, and interpreting the results.
# 
# NOTE: it is assumed that you've already been through Labs 1 through 11
# using Q# before you explore the Qiskit portion of the class, so this will not
# cover the fundamental concepts of quantum software development themselves.


def example_1(circuit, qubits):
    """
    Builds the first example circuit from the Complex Superpositions lecture.

    Parameters:
        circuit (QuantumCircuit): The circuit being constructed
        qubits (QuantumRegister): The qubit register to run the gates on
    """

    # Apply the H gate to the first and second qubits
    circuit.h(qubits[0])
    circuit.h(qubits[1])

    # Apply a CCNOT with qubits 0 and 1 as the controls, and qubit 2 as the target
    circuit.ccx(qubits[0], qubits[1], qubits[2])


def example_2(circuit, qubits):
    """
    Builds the second example circuit from the Complex Superpositions lecture.

    Parameters:
        circuit (QuantumCircuit): The circuit being constructed
        qubits (QuantumRegister): The qubit register to run the gates on
    """
    
    # Apply the H gate to the first and second qubits
    circuit.h(qubits[0])
    circuit.h(qubits[1])

    # This is a CNOT gate
    circuit.cx(qubits[1], qubits[2])

    # These are Z and X gates, respectively
    circuit.x(qubits[2])
    circuit.z(qubits[0])



def example_3(circuit, qubits):
    
    # Apply the H and X gates
    circuit.h(qubits[0])
    circuit.h(qubits[1])
    circuit.x(qubits[2])

    # Qiskit doesn't have the "controlled" keyword and it only has a CZ gate,
    # so we have to make a CCZ gate manually by creating a single ancilla qubit
    # which is flipped if all of the control qubits are flipped, then use that 
    # as the control of a CZ gate.
    ancilla = QuantumRegister(1, "ancilla")     # The name here isn't required, just for documentation
    if not circuit.has_register(ancilla):       # Prevent duplicating the register if this is called multiple times
        circuit.add_register(ancilla)
    circuit.ccx(qubits[0], qubits[1], ancilla)

    circuit.cz(ancilla, qubits[2])


def run_example_on_simulator(example):
    """
    Sets up and executes one of the example circuits.

    Parameters:
        example (function): The example function that will build the requested circuit.
    """

    # This will create a new qubit register with 4 qubits.
    # It will use the default name of "q0".
    qubits = QuantumRegister(3)

    # This will create a corresponding classical register that can be used to store
    # the measurement results of the above register
    measurement = ClassicalRegister(3)

    # This will create a new circuit object with the two registers above added to it
    circuit = QuantumCircuit(qubits, measurement)

    # Build the given example circuit
    example(circuit, qubits)

    # Measure all of the qubits and store the results in the `measurement` classical register
    circuit.measure(qubits, measurement)

    # Print an ASCII version of the circuit diagram for this circuit, so you can see it
    # This can help you catch any mistakes in your implementation of algorithms
    print(circuit)
    
    # Run the circuit with a local simulator 1000 times.
    # Unlike Q#, this will actually only simulate the circuit once to generate the final
    # statevector, then just randomly sample it 1000 times without collapsing the superposition.
    # This means Qiskit can be used to quickly get a statistical distribution of the final state.
    simulator = Aer.get_backend('aer_simulator')
    simulation = execute(circuit, simulator, shots=1000)
    result = simulation.result()

    # Go through a dictionary of all of the results that were measured
    counts = result.get_counts(circuit)
    for(measured_state, count) in counts.items():

        # Qiskit will give you the state in little-endian form by default, so if you want to
        # turn it into big-endian, just reverse the state
        big_endian_state = measured_state[::-1]
        print(f"Measured {big_endian_state} {count} times.")


def run_example_on_hardware(example):
    """
    Sets up and executes one of the example circuits.

    Parameters:
        example (function): The example function that will build the requested circuit.
    """
    
    qubits = QuantumRegister(3)
    measurement = ClassicalRegister(3)
    circuit = QuantumCircuit(qubits, measurement)
    
    example(circuit, qubits)
    circuit.measure(qubits, measurement)

    print(circuit)
    
    provider = IBMQ.load_account()
    backend = provider.get_backend('ibmq_santiago')
    run = execute(circuit, backend, shots=1024)
    result = run.result()

    counts = result.get_counts(circuit)
    for(measured_state, count) in counts.items():
        big_endian_state = measured_state[::-1]
        print(f"Measured {big_endian_state} {count} times.")


# Code runner - change the method below to run a different example
if __name__ == '__main__':
    # Uncomment this line to run a circuit locally on a simulator
    run_example_on_simulator(example_1)

    # Uncomment this line to run a circuit on a real quantum machine
    #run_example_on_hardware(example_1)