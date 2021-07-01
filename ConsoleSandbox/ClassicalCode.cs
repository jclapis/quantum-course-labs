/*
 * Console Sandbox C# Application
 * Copyright 2021 The MITRE Corporation. All Rights Reserved.
 */

using Microsoft.Quantum.Simulation.Simulators;
using System;
using System.Threading.Tasks;

namespace QSharpExercises.ConsoleSandbox
{
    /// <summary>
    /// This project serves as a sandbox for you to play around with Q# and the concepts behind
    /// quantum computing. You are free to do whatever you want here. The project is built as a
    /// console application, so you can run it when you're ready to interact with the program
    /// through a terminal.
    /// 
    /// This class is called the "Driver". Drivers in Q# programs are meant to be classes that can
    /// invoke quantum operations written with Q#. They are essentially just regular .NET classes
    /// written in a classical language like C#, but provide the functionality for invoking your
    /// Q# code.
    /// 
    /// For this project, the driver also serves as the entry-point into the application. You can
    /// modify it however you like when you're experimenting with Q#.
    /// </summary>
    class Driver
    {
        /// <summary>
        /// This is the entry-point to the program. It will start the terminal, then invoke the
        /// quantum simulator with your code. You can replace this with whatever you want - this
        /// is your quantum playground!
        /// 
        /// By default, this will rotate a qubit around the Y axis of the Bloch Sphere (so along
        /// the X-Z plane) by an angle specified by the user, measure the qubit, repeat this whole
        /// process a bunch of times, and print the aggregated results from each trial.
        /// </summary>
        /// <param name="Args">Not used</param>
        static void Main(string[] Args)
        {
            // Print some handy info
            Console.WriteLine("Welcome to the Q# console sandbox! Here you can play with Q# code " +
                "and experiment with qubits.");
            Console.WriteLine("Let's start by rotating a qubit around the Y axis by an arbitrary " +
                "angle, and measuring it to see what the result is.");

            // Get the angle of rotation from the user
            Console.Write("Enter an angle in degrees (floating point is okay): ");
            string angleString = Console.ReadLine();
            double angle;
            while (!double.TryParse(angleString, out angle))
            {
                Console.Write("Invalid angle, try again: ");
                angleString = Console.ReadLine();
            }

            // Get the number of trials from the user (default to 1000)
            Console.Write("Enter the number of trials to measure (leave it blank for the default of 1000): ");
            string countString = Console.ReadLine();
            if (string.IsNullOrEmpty(countString))
            {
                countString = "1000";
            }
            int count;
            while (!int.TryParse(countString, out count))
            {
                Console.Write("Invalid number of trials, try again: ");
                countString = Console.ReadLine();
                if (string.IsNullOrEmpty(countString))
                {
                    countString = "1000";
                }
            }

            // Do the math to figure out the expected |0> and |1> counts - this is all explained during
            // the lectures and labs in class
            double angleInRadians = angle * Math.PI / 180.0;
            double amplitudeOfZero = Math.Cos(angleInRadians / 2.0);
            double amplitudeOfOne = Math.Sin(angleInRadians / 2.0);
            double probabilityOfZero = Math.Pow(amplitudeOfZero, 2);
            double probabilityOfOne = Math.Pow(amplitudeOfOne, 2);
            int estimatedZeroResults = (int)Math.Round(count * probabilityOfZero);
            int estimatedOneResults = (int)Math.Round(count * probabilityOfOne);

            // Print the expected results of the operation
            Console.WriteLine($"With an angle of {angle}° ({angleInRadians} radians), the qubit should be in " +
                $"the superposition {amplitudeOfZero}*|0> + {amplitudeOfOne}*|1>.");
            Console.WriteLine($"The chance it'll be measured as |0> is {probabilityOfZero.ToString("P2")}.");
            Console.WriteLine($"The chance it'll be measured as |1> is {probabilityOfOne.ToString("P2")}.");
            Console.WriteLine($"Based on {count} trials, we should expect around {estimatedZeroResults} |0> " +
                $"measurements and around {estimatedOneResults} |1> measurements.");
            Console.WriteLine();

            // Create a new quantum simulator to run the Q# code
            using (QuantumSimulator simulator = new QuantumSimulator())
            {
                Console.WriteLine("Simulating qubits...");
                int numberOfZeros = 0;

                // Run the quantum function a bunch of times and keep track of the results. The
                // RotateAndMeasureQubit function can be found in QuantumCode.qs.
                for (int i = 0; i < count; i++)
                {
                    Task<long> quantumTask = RotateAndMeasureQubit.Run(simulator, angleInRadians);
                    long result = quantumTask.Result;
                    if (result == 0)
                    {
                        numberOfZeros++;
                    }
                }

                // Print the results!
                Console.WriteLine($"Measured the |0> state {numberOfZeros} times, and the |1> state " +
                    $"{count - numberOfZeros} times.");
                Console.WriteLine();
            }

            // Done.
            Console.WriteLine("Done! Press enter to exit.");
            Console.ReadLine();
        }
    }

}
