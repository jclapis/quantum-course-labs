﻿# List of Building Blocks and Algorithms

This page contains a list of some commonly used "building block" algorithms or subroutines, as well as a list of larger algorithms designed for more specific applications.
You can use this as a reference when exploring quantum algorithms to learn what's out there, what they can be used for, and assess their relative maturity.
If you want to use what you learned in this class to start implementing quantum algorithms in software, this is a good place to start.

There are tens of thousands of peer-reviewed papers describing quantum algorithms in the academic literature today.
We have tried to reduce this down to a few applications with excellent reference material that not only describes *what* the algorithm does, but also describes *how* to build it for practical usage.
This includes, at the least, **a detailed explanation** and **a series of detailed circuit diagrams** with **examples applied to sample data**.

For a much more thorough survey of algorithms, consider looking at the [Quantum Algorithm Zoo](https://quantumalgorithmzoo.org/).


## Building Blocks

This section describes "smaller" algorithms that are frequently used as subroutines in larger algorithms.
They are well-studied, well-defined, and are usually built into existing quantum software framework libraries.
They serve as a great reference to use when practicing algorithm implementation.


### Quantum Arithmetic

These are some algorithms that do basic arithmetic on integers.


#### Full Adder

This circuit adds two arbitrarily large integers together.

References with Circuit Diagrams:

- Vedral, V. & Ekert, A. *Quantum Networks for Elementary Arithmetic Operations.* Phys. Rev. A 54, 147 (1996). [https://doi.org/10.1103/PhysRevA.54.147](https://doi.org/10.1103/PhysRevA.54.147) (**Alternative:** [https://arxiv.org/abs/quant-ph/9511018v1](https://arxiv.org/abs/quant-ph/9511018v1))
- Luo, J., Zhou, RG., Luo, G. et al. *Traceable Quantum Steganography Scheme Based on Pixel Value Differencing.* Sci Rep 9, 15134 (2019). [https://doi.org/10.1038/s41598-019-51598-8](https://doi.org/10.1038/s41598-019-51598-8)
- Ma Y., Ma, H. and Chu, P. *Demonstration of Quantum Image Edge Extration Enhancement Through Improved Sobel Operator.* IEEE Access, vol. 8, pp. 210277-210285, 2020. [https://doi.org/10.1109/ACCESS.2020.3038891](https://doi.org/10.1109/ACCESS.2020.3038891)


#### Two's Complement

This circuit turns an integer into its negative version, represented using the standard [two's complement](https://en.wikipedia.org/wiki/Two%27s_complement) form.
This is used in combination with the adder above to form a **subtractor**.

References with Circuit Diagrams:

- Luo, G., Zhou, RG. & Hu, W. *Efficient quantum steganography scheme using inverted pattern approach.* Quantum Inf Process 18, 222 (2019). [https://doi.org/10.1007/s11128-019-2341-3](https://doi.org/10.1007/s11128-019-2341-3)
- Ma Y., Ma, H. and Chu, P. *Demonstration of Quantum Image Edge Extration Enhancement Through Improved Sobel Operator.* IEEE Access, vol. 8, pp. 210277-210285, 2020. [https://doi.org/10.1109/ACCESS.2020.3038891](https://doi.org/10.1109/ACCESS.2020.3038891)


#### Reverse Parallel Subtractor

This is a version of a subtractor that calculates `X - Y` in-place for two integers.
It's all integerated together into one nice, neat package.

References with Circuit Diagrams:

- Zhou, R.-G., Hu, W., Luo, G., Liu, X., Fan, P.: *Quantum realization of the nearest neighbor value inter-
polation method for INEQR.* Quantum Inf. Process. 17, 166 (2018). [https://doi.org/10.1007/s11128-018-1921-y](https://doi.org/10.1007/s11128-018-1921-y)


#### Cyclic / Position Shift Transformation

This circuit is used to move the elements of an array up or down by some number of indices - it could move everything 2 positions to the left or to the right, for example.
Elements will "wrap around", so if you move all of them one position to the right, the old last element will become the new first element.


References with Circuit Diagrams:

-  Le, P. Q., Iliyasu, A. M., Dong, F. & Hirota, K. *Strategies for designing geometric transformations on quantum images.* Theor. 
Comput. Sci. 412, 1406–1418 (2011). [https://doi.org/10.1016/j.tcs.2010.11.029](https://doi.org/10.1016/j.tcs.2010.11.029)
- Luo, J., Zhou, RG., Luo, G. et al. *Traceable Quantum Steganography Scheme Based on Pixel Value Differencing.* Sci Rep 9, 15134 (2019). [https://doi.org/10.1038/s41598-019-51598-8](https://doi.org/10.1038/s41598-019-51598-8)


#### Divider

This circuit performs divides one integer by another, producing both the result (in integer / floor division) and the remainder.

References with Circuit Diagrams:

- Khosropour, A., Aghababa, H. & Forouzandeh, B. *Quantum Division Circuit Based on Restoring Division Algorithm.* 2011 Eighth 
Int. Conf. Inf. Technol. New Gener. 3–6, (2011). [https://doi.org/10.1109/ITNG.2011.177](https://doi.org/10.1109/ITNG.2011.177)
- Thapliyal, H., Munoz-Coreas, E., T. S. S. Varun and T. S. Humble, "Quantum Circuit Designs of Integer Division Optimizing T-count and T-depth," in IEEE Transactions on Emerging Topics in Computing, vol. 9, no. 2, pp. 1045-1056, 1 April-June 2021. [https://doi.org/10.1109/TETC.2019.2910870](https://doi.org/10.1109/TETC.2019.2910870) (**Alternative:** [https://arxiv.org/abs/1809.09732](https://arxiv.org/abs/1809.09732))


#### Thresholder / Comparator

This circuit has a few forms.
In the "single register" mode, it takes a register and an ancilla qubit and "thresholds" the register, so for values where the register is greater than some value `T`, the ancilla will be flipped to 1.
In the "double register" mode, it compares two registers and flags some ancilla qubits to state if A is larger than B, if A is greater than B, or if they're equal.

References with Circuit Diagrams:

- Ma Y., Ma, H. and Chu, P. *Demonstration of Quantum Image Edge Extration Enhancement Through Improved Sobel Operator.* IEEE Access, vol. 8, pp. 210277-210285, 2020. [https://doi.org/10.1109/ACCESS.2020.3038891](https://doi.org/10.1109/ACCESS.2020.3038891)
- Luo, G., Zhou, RG. & Hu, W. *Efficient quantum steganography scheme using inverted pattern approach.* Quantum Inf Process 18, 222 (2019). [https://doi.org/10.1007/s11128-019-2341-3](https://doi.org/10.1007/s11128-019-2341-3)


### Classical Data Encoding

These algorithms are used to represent arbitrary classical data, such as an image, in qubits using superposition.


#### Flexible Representation of Quantum Images (FRQI)

This method uses a single register to represent the index of an element in a 1D array.
The value of the element at that index is encoded as the *amplitude* of the index register.
In other words, the entire classical array is stored in the amplitudes of the corresponding states at each index.

As you might expect, it uses a lot of controlled `Ry` gates.

References with Circuit Diagrams:

- Le, P. Q., Dong, F. & Hirota, K. *A flexible representation of quantum images for polynomial preparation, image compression, and 
processing operations.* Quantum Inf. Process. 10, 63–84 (2011). [https://doi.org/10.1007/s11128-010-0177-y](https://doi.org/10.1007/s11128-010-0177-y)


#### Novel Enhanced Quantum Representation (NEQR) / Generalized Quantum Image Representation (GQIR)

NEQR stores classical data in two registers: an *index* and a *value*.
The two are entangled together so the value register will contain the classical data value at index `i` when the index register is in state `i`.
Formally, this will represent the classical data (call it `c`) in the superposition `|i, c[i]>` with uniform amplitudes for each state.

NEQR is limited to square images with a power of 2 as the width; GQIR is simply a generalized form that works with classical data of arbitrary sizes.

References with Circuit Diagrams:

- Zhang, Y., Lu, K., Gao, Y. & Wang, M. *NEQR: A novel enhanced quantum representation of digital images.* Quantum Inf. Process. 12, 
2833–2860 (2013). [https://doi.org/10.1007/s11128-013-0567-z](https://doi.org/10.1007/s11128-013-0567-z)
- Jiang, N., Wang, J. & Mu, Y. *Quantum image scaling up based on nearest-neighbor interpolation with integer scaling ratio.* Quantum Inf Process 14, 4001–4026 (2015). [https://doi.org/10.1007/s11128-015-1099-5](https://doi.org/10.1007/s11128-015-1099-5)


### Simple Algorithms

These are basic algorithms used as subroutines in several larger applications, which offer more than basic arithmetic.


#### Quantum Phase Estimation

QPE is used to estimate the eigenvector of a quantum operation.
This is a fundamentally useful thing in a wide variety of applications - for example, Shor's algorithm uses this to get the value of the period of modular exponentiation.

[Qiskit Textbook Section on QPE](https://qiskit.org/textbook/ch-algorithms/quantum-phase-estimation.html)


#### Amplitude Amplification

This is a generalized form of Grover's algorithm that works when there's more than one "correct" answer to a problem.
It amplifies the amplitude of all of the correct answers equally.

Brassard, G., Hoyer, P., Mosca, M. & Tapp, A. *Quantum Amplitude Amplification and Estimation.* Quantum Computation and Quantum Information, Samuel J. Lomonaco, Jr. (editor), AMS Contemporary Mathematics, 305:53-74, 2002. [https://doi.org/10.1090/conm/305/05215](https://doi.org/10.1090/conm/305/05215) (**Alternative:** [https://arxiv.org/abs/quant-ph/0005055](https://arxiv.org/abs/quant-ph/0005055))


#### Amplitude Estimation / Quantum Counting

This is a general purpose algorithm that actually retrieves the amplitude of a given state (or rather, the aggregated amplitude for all of the "correct" states in the Amplitude Amplification algorithm).
It is a combination of Grover's and Shor's (or more accurately Amplitude Amplification and QPE), though the last paper in this list describes a way to do it *without* QPE.

This is also used to calculate the *number of correct states*, which is helpful in many computational fields.
When used in this way, Amplitude Estimation is known as the [Quantum Counting algorithm](https://en.wikipedia.org/wiki/Quantum_counting_algorithm).

Brassard, G., Hoyer, P., Mosca, M. & Tapp, A. *Quantum Amplitude Amplification and Estimation.* Quantum Computation and Quantum Information, Samuel J. Lomonaco, Jr. (editor), AMS Contemporary Mathematics, 305:53-74, 2002. [https://doi.org/10.1090/conm/305/05215](https://doi.org/10.1090/conm/305/05215) (**Alternative:** [https://arxiv.org/abs/quant-ph/0005055](https://arxiv.org/abs/quant-ph/0005055))

Stamatopoulos, N., Egger, D., Sun, Y. et al. *Option Pricing using Quantum Computers.* Quantum 4, 291 (2020). [https://doi.org/10.22331/q-2020-07-06-291](https://doi.org/10.22331/q-2020-07-06-291)

Suzuki, Y., Uno, S., Raymond, R. et al. *Amplitude estimation without phase estimation.* Quantum Inf Process 19, 75 (2020). [https://doi.org/10.1007/s11128-019-2565-2](https://doi.org/10.1007/s11128-019-2565-2)


### Quantum Protocols

These are simple protocols that can be easily developed for practical purposes.
The aren't necessarily algorithms, but they do leverage qubits and quantum gates for some kind of application.


#### Quantum Secret Sharing

This protocol is similar to the Superdense Coding protocol; it's a way to securely embed information into a quantum system which can be passed to remote users without any chance of an eavesdropper recovering the information.
It has uses in secure communications (such as a quantum voting system).

Joy, D., Sabir, M., Behera, B.K. et al. *Implementation of quantum secret sharing and quantum binary voting protocol in the IBM quantum computer.* Quantum Inf Process 19, 33 (2020). [https://doi.org/10.1007/s11128-019-2531-z](https://doi.org/10.1007/s11128-019-2531-z)


### Complex Algorithms

These algorithms are used as subroutines in larger algorithms, but they are considerably more complex than the examples above.


#### Variational Quantum Eigensolver

[VQE is an algorithm](https://developer.ibm.com/depmodels/quantum-computing/blogs/quantum-computing-qubit-vqe-variational-quantum-eigensolver/) with a lot of potential use cases.
It can be used to solve optimization problems, including solving the molecular structure and details of interesting new molecules.
It is being investigated for materials science applications, and is one of the most promising quanutm algorithms for near-term usage because it requires a fairly small number of qubits.

[Qiskit Textbook Section on VQE](https://qiskit.org/textbook/ch-applications/vqe-molecules.html)


#### Quantum Linear Systems of Equations Algorithm (QLSA / HHL)

The Quantum Linear-Solving Algorithm, also named the HHL algorithm after its authors, uses a quantum computer to solve a system of linear equations, similar to how the classical step of Simon's algorithm works but on general-purpose equations.
This has usage in many fields, from finance simulation to fluid dynamics.

[Qiskit Textbook Section on QLSA / HHL](https://qiskit.org/textbook/ch-applications/hhl_tutorial.html)


#### Quantum Approximate Optimization Algorithm

QAOA is an interesting algorithm that finds an "approximately optimal" solution to a combinatorial optimization problem fairly quickly.
You can adjust how "approximate" the solution is; the closer you get to the ideal option, the longer it'll take, so if you just need something "good enough" this can find it for you in a reasonable amount of time.

[Qiskit Textbook Section on QAOA](https://qiskit.org/textbook/ch-applications/qaoa.html)


#### Quantum Neural Network

There are a lot of methods and algorithms to run a neural network on a quantum computer.
This one provides a hybrid method that uses a quantum subroutine as part of a [feed-forward neural network](https://en.wikipedia.org/wiki/Feedforward_neural_network).
*Note that you'll need to have some understanding of machine learning theory already to use this algorithm.*

[Qiskit Textbook Section on Hybrid Quantum Neural Networks](https://qiskit.org/textbook/ch-machine-learning/machine-learning-qiskit-pytorch.html)


## Applied Algorithms

These are larger, more complex quantum algorithms tailored to specific applications that tend to use some of the building blocks described earlier.


#### Variational Quantum Classifier

This is a machine-learning algorithm that provides a neural network with some data, and asks it to make a binary choice based on the data.
In other words, it attempts to sort the entity the data belongs to into one of two groups.
For example: given a picture, tell whether or not it is a picture of a cat.
As another example: given this set of health metrics, tell whether or not this person is at high risk for a heart attack.

[Rodney David's introductory article on VQC](https://medium.com/swlh/qa2-explaining-variational-quantum-classifiers-b584c3bd7849)


#### Quantum Kernel Estimation

This algorithm is used in machine learning to augment Support Vector Machines.
It finds the kernel functions for general-purpose nonlinear classifier problems, which are used in pattern recognition systems to determine which group / label a particular input belongs to.

Havlíček, V., Córcoles, A.D., Temme, K. et al. *Supervised learning with quantum-enhanced feature spaces.* Nature 567, 209–212 (2019). [https://doi.org/10.1038/s41586-019-0980-2](https://doi.org/10.1038/s41586-019-0980-2)


### Variational Quantum Linear Solver

This algorithm uses the Variational Quantum Eigensolver to solve a linear system of equations.
This is similar to the HHL / QLSA algorithm, but can be run with much fewer qubits so it's closer to being used practically.

[Qiskit Textbook Section on the VQLS Algorithm](https://qiskit.org/textbook/ch-paper-implementations/vqls.html)


### Fast Poisson Solver

The [Poisson equation](https://en.wikipedia.org/wiki/Poisson%27s_equation) has applications across many areas of physics and engineering, such as the dynamic process simulation of ocean current.
This paper presents a quantum algorithm for solving Poisson equation, as well as a complete and modular circuit design.
It's based on the HHL / QLSA algorithm, but offers several improvements that reduce the overall circuit complexity.

Wang, S., Wang, Z., Li, W. et al. *Quantum fast Poisson solver: the algorithm and complete and modular circuit design.* Quantum Inf Process 19, 170 (2020). [https://doi.org/10.1007/s11128-020-02669-7](https://doi.org/10.1007/s11128-020-02669-7)


### Least Squares Solver

This algorihtm solves the [least squares problem](https://en.wikipedia.org/wiki/Least_squares) that fits a curve to a set of data points.
It uses HHL / QLSA, Amplitude Estimation, and Grover's Algorithm together to do this faster than a classical computer.

Shao, C., Xiang, H. *Quantum regularized least squares solver with parameter estimate.* Quantum Inf Process 19, 113 (2020). [https://doi.org/10.1007/s11128-020-2615-9](https://doi.org/10.1007/s11128-020-2615-9)


### Image Segmentation Filter

This algorithm provides a dual-threshold filter that clips values of an array that are either too low or too high, leaving only values that are in the middle.
This is useful across a range of in data processing tasks, such as audio or image processing.

Yuan, S., Wen, C., Hang, B. et al. *The dual-threshold quantum image segmentation algorithm and its simulation.* Quantum Inf Process 19, 425 (2020). [https://doi.org/10.1007/s11128-020-02932-x](https://doi.org/10.1007/s11128-020-02932-x)


### JPEG decompression

One of the hardest problems in quantum computing right now is finding an efficient way to encode classical data into a quantum superposition, so that we can take advantage of quantum data processing.
This method uses the JPEG compression scheme to encode / compress the classical data, and implements a JPEG decompressor on the quantum side to decompress it and retrieve the "original" data (though it is in a lossy form, so it's only an approximate of the original data).
It's mainly used in image and video processing.

Jiang, N., Lu, X., Hu, H. et al. A Novel Quantum Image Compression Method Based on JPEG. Int J Theor Phys 57, 611–636 (2018). [https://doi.org/10.1007/s10773-017-3593-2](https://doi.org/10.1007/s10773-017-3593-2)


### Steganography

[Steganography](https://en.wikipedia.org/wiki/Steganography) is the practice of hiding a "secret" message within another "cover" (disguise) message, such as hiding secret text inside of an image that otherwise looks totally normal.
These two papers offer different techniques for accomplishing this using quantum computers.

Luo, G., Zhou, RG. & Hu, W. *Efficient quantum steganography scheme using inverted pattern approach.* Quantum Inf Process 18, 222 (2019). [https://doi.org/10.1007/s11128-019-2341-3](https://doi.org/10.1007/s11128-019-2341-3)

Luo, J., Zhou, RG., Luo, G. et al. *Traceable Quantum Steganography Scheme Based on Pixel Value Differencing. Sci Rep 9, 15134 (2019).* [https://doi.org/10.1038/s41598-019-51598-8](https://doi.org/10.1038/s41598-019-51598-8)


### Image Classifier

This gives a way of classifying images (determining which set or label they belong to, such as "this is an airplane" vs. "this is a leopard") faster than classical machine learning systems.
It uses the Quantum Comparator and Amplitude Estimation in clever ways to do it.

Dang, Y., Jiang, N., Hu, H. et al. Image classification based on quantum K-Nearest-Neighbor algorithm. Quantum Inf Process 17, 239 (2018). [https://doi.org/10.1007/s11128-018-2004-9](https://doi.org/10.1007/s11128-018-2004-9)


### Edge Extraction Filter

This algorithm processes an image by setting all of the pixels representing object edges to white, and other pixels to black - an important operation in computer vision and machine learning.
The papers below provide ways to do this, and claim that this is more accurate than classical methods.

Zhou, RG., Liu, DQ. *Quantum Image Edge Extraction Based on Improved Sobel Operator.* Int J Theor Phys 58, 2969–2985 (2019). [https://doi.org/10.1007/s10773-019-04177-6](https://doi.org/10.1007/s10773-019-04177-6)

Ma Y., Ma, H. and Chu, P. *Demonstration of Quantum Image Edge Extration Enhancement Through Improved Sobel Operator.* IEEE Access, vol. 8, pp. 210277-210285, 2020. [https://doi.org/10.1109/ACCESS.2020.3038891](https://doi.org/10.1109/ACCESS.2020.3038891)