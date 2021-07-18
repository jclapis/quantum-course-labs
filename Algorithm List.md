# List of Building Blocks and Algorithms

This page contains a list of some commonly used "building block" algorithms or subroutines, as well as a list of larger algorithms designed for more specific applications.
You can use this as a reference when exploring quantum algorithms to learn what's out there, what they can be used for, and assess their relative maturity.
If you want to use what you learned in this class to start implementing quantum algorithms in software, this is a good place to start.

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


#### Amplitude Amplification


#### Amplitude Estimation


### Quantum Protocols

These are simple protocols that can be easily developed for practical purposes.
The aren't necessarily algorithms, but they do leverage qubits and quantum gates for some kind of application.


#### Quantum Secret Sharing



### Complex Algorithms

These algorithms are used as subroutines in larger algorithms, but they are considerably more complex than the examples above.


#### Variational Quantum Eigensolver


#### Quantum Linear Systems of Equations Algorithm (QLSA / HHL)


#### Quantum Approximate Optimization Algorithm


#### Quantum Neural Network


#### Variational Quantum Classifier


#### Quantum Kernel Estimation


## Applied Algorithms

These are larger, more complex quantum algorithms tailored to specific applications that tend to use some of the building blocks described earlier.


### Variational Quantum Linear Solver


### Fast Poisson Solver


### Least Squares Solver


### Image Segmentation Filter


### JPEG compression


### Steganography


### Image Classifier


### Edge Extraction Filter

