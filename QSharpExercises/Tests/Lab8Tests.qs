// Tests for Lab 8: The Quantum Fourier Transform
// Copyright 2021 The MITRE Corporation. All Rights Reserved.

namespace QSharpExercises.Tests.Lab8 {
    
    open Microsoft.Quantum.Arithmetic;
    open Microsoft.Quantum.Preparation;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Random;

    open QSharpExercises.Lab8;
    // open QSharpExercises.Solutions.Lab8;

	operation PrepareSineWaveSamples(
		Frequency : Double,
		SampleRate : Double,
		Register : Qubit[],
		UseCosine : Bool
	) : Unit
	{
		let numberOfSamples = 2 ^ Length(Register);
		// Since quantum states need to be unit vectors, this will be used to reduce the
		// sin / cos output properly.
		let normalizationFactor = Sqrt(IntAsDouble(numberOfSamples) / 2.0);
		
		mutable samples = new ComplexPolar[numberOfSamples];
		for i in 0..numberOfSamples - 1
		{
			let timestamp = IntAsDouble(i) / SampleRate;
			mutable sample = 0.0;
			if(UseCosine)
			{
				set sample = Cos(Frequency * 2.0 * PI() * timestamp) / normalizationFactor;
			}
			else
			{
				set sample = Sin(Frequency * 2.0 * PI() * timestamp) / normalizationFactor;
			}
			set samples w/= i <- ComplexPolar(sample, 0.0);
		}

		// This is such a handy function. Props to the guys that wrote it.
		PrepareArbitraryStateCP(samples, BigEndianAsLittleEndian(BigEndian(Register)));
	}


	operation TestQftWithWaveformSamples(
		PrepOperation : (Qubit[] => Unit),
		NumberOfQubits : Int,
		SampleRate : Double,
		CorrectFrequency : Double
	) : Unit
	{
		use register = Qubit[NumberOfQubits]
		{
			// Set up the register so it's in the correct state for the test
			PrepOperation(register);

			// Run the inverse QFT, which corresponds to the normal DFT
			Adjoint Exercise1(BigEndian(register));

			// Measure the result from QFT
			let numberOfStates = IntAsDouble(2 ^ NumberOfQubits);
			mutable result = IntAsDouble(MeasureInteger(BigEndianAsLittleEndian(BigEndian(register))));

			// QFT suffers from the same Nyquist-frequency mirroring as DFT, but we can't just
			// look at all of the output details and ignore the mirrored results. If we end up
			// measuring a mirrored result, this will flip it back to the proper result in the
			// 0 < X < N/2 space.
			if(result > numberOfStates / 2.0)
			{
				set result = numberOfStates - result;
			}

			// Correct for the sample rate.
			let totalTime = numberOfStates / SampleRate;
			set result = result / totalTime;

			// Verify we got the right result, and clean up
			if(result != CorrectFrequency)
			{
				fail $"Expected frequency {CorrectFrequency} but measured {result}.";
			}
			ResetAll(register);
		}
	}

	operation Exercise1Wrapper (
		register : Qubit[]
	) : Unit is Adj + Ctl
	{
		let wrappedRegister = BigEndian(register);
		Exercise1(wrappedRegister);
	}


	operation QftWrapper (
		register : Qubit[]
	) : Unit is Adj + Ctl
	{
		let wrappedRegister = BigEndian(register);
		QFT(wrappedRegister);
	}
    

    @Test("QuantumSimulator")
    operation Exercise1QftTest () : Unit {
		for i in 3..10 {
			AssertOperationsEqualReferenced(i, Exercise1Wrapper, QftWrapper);
		}
    }

	
    @Test("QuantumSimulator")
	operation Exercise2GetFrequencyTest () : Unit {
		for sampleRatePower in 3..5 {
			let sampleRate = 2 ^ sampleRatePower;
			let sampleRateAsDouble = IntAsDouble(sampleRate);

			for frequency in 1..3 {
				let frequencyAsDouble = IntAsDouble(frequency);
				let sinPrepFunction = PrepareSineWaveSamples(
					frequencyAsDouble, 
					sampleRateAsDouble, 
					_,
					false);
				let cosPrepFunction = PrepareSineWaveSamples(
					frequencyAsDouble, 
					sampleRateAsDouble, 
					_,
					true);

				for numberOfQubits in sampleRatePower..6 {
					
					use register = Qubit[numberOfQubits] {
						sinPrepFunction(register);
						let measuredFrequency = Exercise2(BigEndian(register), sampleRateAsDouble);
						if not (measuredFrequency == frequencyAsDouble) {
							fail $"Expected {frequencyAsDouble} Hz, but you measured {measuredFrequency} Hz.";
						}
						ResetAll(register);
					}
					use register = Qubit[numberOfQubits] {
						cosPrepFunction(register);
						let measuredFrequency = Exercise2(BigEndian(register), sampleRateAsDouble);
						if not (measuredFrequency == frequencyAsDouble) {
							fail $"Expected {frequencyAsDouble} Hz, but you measured {measuredFrequency} Hz.";
						}
						ResetAll(register);
					}
				}
			}
		}
	}

}
