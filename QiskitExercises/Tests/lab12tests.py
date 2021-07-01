# Tests for Lab 12: Deutsch-Jozsa Algorithm
# Copyright 2021 The MITRE Corporation. All Rights Reserved.

import vs_test_path_fixup
import unittest
import os
import sys
sys.path.insert(1, os.path.realpath(os.path.pardir))

from qiskit import QuantumCircuit, ClassicalRegister, QuantumRegister
from qiskit import execute
from qiskit import Aer
import lab12
import random


def exercise_3_wrapper(circuit, input, output):
    first_index = random.randint(0, len(input) - 1)
    second_index = random.randint(0, len(input) - 2)
    if second_index == first_index:
        second_index += 1

    return lab12.exercise_2(circuit, first_index, second_index, input, output)


class Lab12Tests(unittest.TestCase):

    def test_exercise_1(self):
        for number_of_qubits in range(3,9):
            input_qubits = QuantumRegister(number_of_qubits)
            target = QuantumRegister(1)
            qubit_measurement = ClassicalRegister(number_of_qubits)
            target_measurement = ClassicalRegister(1)
            circuit = QuantumCircuit(input_qubits, target, qubit_measurement, target_measurement)

            circuit.h(input_qubits)
            circuit.h(target)

            lab12.exercise_1(circuit, input_qubits, target)

            circuit.h(target)

            circuit.measure(input_qubits, qubit_measurement)
            circuit.measure(target, target_measurement)
            
            simulator = Aer.get_backend('aer_simulator')
            simulation = execute(circuit, simulator, shots=100)
            result = simulation.result()
            counts = result.get_counts(circuit)
            
            for(state, count) in counts.items():
                big_endian_state = state[::-1]
                states = big_endian_state.split(' ')
                qubits_state = states[0]
                target_state = states[1]

                number_of_ones = 0
                for char in qubits_state:
                    if char == "1":
                        number_of_ones += 1

                if number_of_ones % 2 == 0 and result == "1":
                    self.fail(f"Measured even number of qubits in the |1> state, but the target qubit was flipped.")
                elif number_of_ones % 2 == 1 and result == "0":
                    self.fail(f"Measured odd number of qubits in the |1> state, but the target qubit was not flipped.")

        print("Exercise 1 passed!")


    def test_exercise_2(self):
        for number_of_qubits in range(3, 9):
            input_qubits = QuantumRegister(number_of_qubits)
            target = QuantumRegister(1)
            measurement = ClassicalRegister(number_of_qubits)
            circuit = QuantumCircuit(input_qubits, target, measurement)

            first_index = random.randint(0, number_of_qubits - 1)
            second_index = random.randint(0, number_of_qubits - 2)
            if second_index == first_index:
                second_index += 1

            circuit.h(input_qubits)
            circuit.x(target)

            lab12.exercise_2(circuit, first_index, second_index, input_qubits, target)
            
            circuit.x(target)
            circuit.h(input_qubits)
            circuit.measure(input_qubits, measurement)
            
            simulator = Aer.get_backend('aer_simulator')
            simulation = execute(circuit, simulator, shots=100)
            result = simulation.result()
            counts = result.get_counts(circuit)
            
            for(state, count) in counts.items():
                big_endian_state = state[::-1]
                states = big_endian_state.split(' ')
                qubits_state = states[0]

                for index in range(0, number_of_qubits):
                    if index == first_index or index == second_index:
                        if qubits_state[index] == "0":
                            self.fail("Expected the parity flag to be flipped, but it was not.")
                    else:
                        if qubits_state[index] == "1":
                            self.fail("Expected the parity flag not to be flipped, but it was flipped.")

        print("Exercise 2 passed!")


    def test_exercise_3(self):
        for i in range(0, 10):
            for number_of_qubits in range(3, 9):

                if lab12.exercise_3(number_of_qubits, lab12.always_zero) == False:
                    self.fail("Incorrectly classified always_zero as balanced.")

                if lab12.exercise_3(number_of_qubits, lab12.always_one) == False:
                    self.fail("Incorrectly classified always_one as balanced.")

                if lab12.exercise_3(number_of_qubits, lab12.exercise_1) == True:
                    self.fail("Incorrectly classified exercise_1 as constant.")

                if lab12.exercise_3(number_of_qubits, exercise_3_wrapper) == True:
                    self.fail("Incorrectly classified exercise_2 as constant.")

        print("Exercise 3 passed!")




if __name__ == '__main__':
    unittest.main()