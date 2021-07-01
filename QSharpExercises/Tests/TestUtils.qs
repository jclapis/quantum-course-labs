// Utility operations for unit tests.
// Copyright 2021 The MITRE Corporation. All Rights Reserved.

namespace QSharpExercises.Tests.Utils {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Random;


    operation GenerateRandomRotation () : Double[] {
        return [
            DrawRandomDouble(0.0, PI()),
            DrawRandomDouble(0.0, 2.0 * PI())
        ];
    }


    operation ApplyRotation (rotation : Double[], target: Qubit) : Unit
    is Adj + Ctl {
        Rx(rotation[0], target);
        Rz(rotation[1], target);
    }
}
