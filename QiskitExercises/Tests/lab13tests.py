# Tests for Lab 13: Grover's Algorithm
# Copyright 2021 The MITRE Corporation. All Rights Reserved.


import vs_test_path_fixup
import unittest
import os
import sys
sys.path.insert(1, os.path.realpath(os.path.pardir))

from qiskit import QuantumCircuit, ClassicalRegister, QuantumRegister
from qiskit import execute
from qiskit import Aer
import lab13
import random

class Lab13Tests(unittest.TestCase):

    def test_exercise_1(self):
        test_cases = [
                [False, True, True],
                [True, False, True, True],
                [True, True, False, True, False],
                [False, False, True, True, False, True],
                [True, True, True, True, False, True, True],
                [True, True, True, True, True, True, True, True],
                [True, False, False, True, True, False, False, True, True],
                [True, False, True, True, False, True, False, True, True, False]
            ]

        for test_case in test_cases:
            length = len(test_case)
            qubits = QuantumRegister(length)
            qubit_measurement = ClassicalRegister(length)
            circuit = QuantumCircuit(qubits, qubit_measurement)

            random_state = [random.randint(0, 1) for i in range(length)]
            for i in range(length):
                if random_state[i] == 1:
                    circuit.x(qubits[i])

            lab13.exercise_1(circuit, test_case, qubits)

            circuit.measure(qubits, qubit_measurement)

            simulator = Aer.get_backend('aer_simulator')
            simulation = execute(circuit, simulator, shots=100)
            result = simulation.result()
            counts = result.get_counts(circuit)
            
            for(state, count) in counts.items():
                big_endian_state = state[::-1]
                for i in range(len(state)):
                    if int(big_endian_state[i]) != (test_case[i] != random_state[i]):
                        self.fail(f"Incorrect result for {test_case[i]} XOR {bool(random_state[i])}")

        print("Exercise 1 passed!")

        
    def test_exercise_2(self):
        for number_of_qubits in range(3, 9):
            qubits = QuantumRegister(number_of_qubits)
            target = QuantumRegister(1)
            qubit_measurement = ClassicalRegister(number_of_qubits)
            target_measurement = ClassicalRegister(1)
            circuit = QuantumCircuit(qubits, target, qubit_measurement, target_measurement)

            circuit.h(qubits)
            circuit.h(target)

            lab13.exercise_2(circuit, qubits, target)

            circuit.h(target)

            circuit.measure(qubits, qubit_measurement)
            circuit.measure(target, target_measurement)
            
            simulator = Aer.get_backend('aer_simulator')
            simulation = execute(circuit, simulator, shots=1000)
            result = simulation.result()
            counts = result.get_counts(circuit)
            
            for(state, count) in counts.items():
                big_endian_state = state[::-1]
                states = big_endian_state.split(' ')
                qubits_state = states[0]
                target_state = states[1]

                state_int = int(qubits_state, 2)
                if state_int == 0 and target_state != "1":
                    self.fail(f"You flagged state {qubits_state} as not-all-zeros but it was.")
                elif state_int != 0 and target_state != "0":
                    self.fail(f"You flagged state {qubits_state} as all-zeros but it was not.")
                    
        print("Exercise 2 passed!")


    def test_exercise_3(self):
        for number_of_qubits in range(3, 9):
            qubits = QuantumRegister(number_of_qubits)
            target = QuantumRegister(1)
            qubit_measurement = ClassicalRegister(number_of_qubits)
            target_measurement = ClassicalRegister(1)
            circuit = QuantumCircuit(qubits, target, qubit_measurement, target_measurement)

            original = [random.randint(0, 1) for i in range(number_of_qubits)]
            key = [random.randint(0, 1) for i in range(number_of_qubits)]
            encrypted = [(original[i] != key[i]) for i in range(number_of_qubits)]

            circuit.h(qubits)
            circuit.h(target)

            lab13.exercise_3(circuit, original, encrypted, qubits, target)

            circuit.h(target)

            circuit.measure(qubits, qubit_measurement)
            circuit.measure(target, target_measurement)
            
            simulator = Aer.get_backend('aer_simulator')
            simulation = execute(circuit, simulator, shots=1000)
            result = simulation.result()
            counts = result.get_counts(circuit)
            
            for(state, count) in counts.items():
                big_endian_state = state[::-1]
                states = big_endian_state.split(' ')
                qubits_state = states[0]
                target_state = states[1]

                found_key = True
                for i in range(number_of_qubits):
                    if int(qubits_state[i]) != key[i]:
                        found_key = False
                        break

                if found_key and target_state != "1":
                    self.fail(f"You flagged state {qubits_state} as the incorrect key, but it was correct.")
                elif not found_key and target_state != "0":
                    self.fail(f"You flagged state {qubits_state} as the correct key, but the correct key was {key}.")

        print("Exercise 3 passed!")


    def test_exercise_4(self):
        for number_of_qubits in range(3, 9):
            qubits = QuantumRegister(number_of_qubits)
            target = QuantumRegister(1)
            qubit_measurement = ClassicalRegister(number_of_qubits)
            target_measurement = ClassicalRegister(1)
            circuit = QuantumCircuit(qubits, target, qubit_measurement, target_measurement)

            original = [random.randint(0, 1) for i in range(number_of_qubits)]
            key = [random.randint(0, 1) for i in range(number_of_qubits)]
            encrypted = [(original[i] != key[i]) for i in range(number_of_qubits)]

            circuit.h(qubits)
            circuit.x(target)

            oracle = lambda circuit_arg, qubit_arg, target_arg : lab13.exercise_3(circuit_arg, original, encrypted, qubit_arg, target_arg)
            lab13.exercise_4(circuit, oracle, qubits, target)

            circuit.h(qubits)
            lab13.exercise_2(circuit, qubits, target)
            circuit.h(qubits)

            lab13.exercise_3(circuit, original, encrypted, qubits, target)
            circuit.x(target)
            circuit.h(qubits)

            circuit.measure(qubits, qubit_measurement)
            circuit.measure(target, target_measurement)
            
            simulator = Aer.get_backend('aer_simulator')
            simulation = execute(circuit, simulator, shots=1000)
            result = simulation.result()
            counts = result.get_counts(circuit)
            
            for(state, count) in counts.items():
                big_endian_state = state[::-1]
                states = big_endian_state.split(' ')
                qubits_state = states[0]
                target_state = states[1]

                if int(qubits_state) != 0 or int(target_state) != 0:
                    self.fail(f"State should be 0 but it was {big_endian_state}.")

        print("Exercise 4 passed!")


    def test_exercise_5(self):
        original = None
        encrypted = None
        oracle = lambda circuit_arg, qubit_arg, target_arg : lab13.exercise_3(circuit_arg, original, encrypted, qubit_arg, target_arg)

        for number_of_qubits in range(6, 11):
            original = [random.randint(0, 1) for i in range(number_of_qubits)]
            key = [random.randint(0, 1) for i in range(number_of_qubits)]
            encrypted = [(original[i] != key[i]) for i in range(number_of_qubits)]

            print(f"Running Grover search on {number_of_qubits} qubits.")
            print(f"Original = {original}")
            print(f"Encrypted = {encrypted}")
            
            for i in range(10):
                found_correct_key = True
                result = lab13.exercise_5(oracle, number_of_qubits)

                print(f"Search returned {result}")

                for j in range(number_of_qubits):
                    measured_qubit = int(result[j])
                    if int(result[j]) != key[j]:
                        found_correct_key = False
                        break

                if found_correct_key:
                    print(f"Test with {number_of_qubits} qubits passed.")
                    print("")
                    break
                else:
                    print("Incorrect key, trying again...")

            if not found_correct_key:
                self.fail("Exceeded the number of tries, Grover's algorithm failed.")
        
        print("Exercise 5 passed!")


if __name__ == '__main__':
    unittest.main()