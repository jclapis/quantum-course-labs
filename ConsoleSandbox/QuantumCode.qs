// This file is where you can define your own custom quantum operations in Q#
// and call them from the driver contained in ClassicalCode.cs. You can do
// whatever you want in here. Have fun experimenting!
//
// Copyright 2021 The MITRE Corporation. All Rights Reserved.

namespace QSharpExercises.ConsoleSandbox {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;


    /// # Summary
    /// Rotates a qubit (starting in the |0> state) around the Y axis of the
    /// Bloch Sphere by the given angle, measures it, and returns the result.
    /// 
    /// # Input
    /// ## angle
    /// The angle (in radians) to rotate the qubit by. This angle should be
    /// measured from the +Z axis, towards the +X axis.
    /// 
    /// # Output
    /// 0 if the qubit was measured in the |0> state, 1 if the qubit was
    /// measured in the |1> state.
    operation RotateAndMeasureQubit (angle : Double) : Int {
        use qubit = Qubit();    // Allocate a qubit
        Ry(angle, qubit);       // Rotate it around the Y axis
        let result = M(qubit);  // Measure it
        let resultInt = (result == One ? 1 | 0);    // Convert result to an Int

        Reset(qubit);           // Reset the qubit to the |0> state for cleanup
        return resultInt;
    }
}
