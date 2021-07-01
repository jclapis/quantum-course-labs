# Copyright 2021 The MITRE Corporation. All Rights Reserved.

from qiskit import QuantumCircuit, ClassicalRegister, QuantumRegister
from qiskit.providers.aer import AerSimulator
from qiskit import IBMQ
from qiskit.compiler import transpile
from time import perf_counter

# Initialization
qubits = QuantumRegister(3)
measurement = ClassicalRegister(3)
circuit = QuantumCircuit(qubits, measurement)

# Build the circuit
start = perf_counter()
circuit.h(qubits[0])
circuit.h(qubits[1])
circuit.ccx(qubits[0], qubits[1], qubits[2])
circuit.measure(qubits, measurement)
end = perf_counter()
print(f"Circuit construction took {(end - start)} sec.")
print(circuit)

# Get the number of qubits needed to run the circuit
active_qubits = {}
for op in circuit.data:
    if op[0].name != "barrier" and op[0].name != "snapshot":
        for qubit in op[1]:
                active_qubits[qubit.index] = True
print(f"Width: {len(active_qubits)} qubits")

# Get some other metrics
print(f"Depth: {circuit.depth()}")
print(f"Gate counts: {circuit.count_ops()}")

# Transpile the circuit to something that can run on the Santiago machine
provider = IBMQ.load_account()
machine = "ibmq_santiago"
backend = provider.get_backend(machine)

print(f"Transpiling for {machine}...")
start = perf_counter()
circuit = transpile(circuit, backend=backend, optimization_level=1)
end = perf_counter()
print(f"Compiling and optimizing took {(end - start)} sec.")
print(circuit)

# Get the number of qubits needed to run the circuit
active_qubits = {}
for op in circuit.data:
    if op[0].name != "barrier" and op[0].name != "snapshot":
        for qubit in op[1]:
                active_qubits[qubit.index] = True
print(f"Width: {len(active_qubits)} qubits")

# Get some other metrics
print(f"Depth: {circuit.depth()}")
print(f"Gate counts: {circuit.count_ops()}")

# Simulate a run on Santiago, using its real gate information to model the output with real errors
santiago_sim = AerSimulator.from_backend(backend)
result = santiago_sim.run(circuit).result()
counts = result.get_counts(circuit)
for(measured_state, count) in counts.items():
    big_endian_state = measured_state[::-1]
    print(f"Measured {big_endian_state} {count} times.")

from qiskit.test.mock import FakeMontreal
montreal_backend = FakeMontreal()

# Feel free to put other circuit experiments using this backend here and play around!
