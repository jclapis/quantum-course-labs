/*
 * Copyright 2021 The MITRE Corporation. All Rights Reserved.
 */

using Xunit;

namespace CSharpExercises
{
    public class Tests
    {
        // readonly Solutions E = new Solutions();
        readonly Exercises E = new Exercises();

        [Fact]
        public void Exercise1Test()
        {
            for (int i = 0; i < 10; i++)
            {
                Assert.Equal(new int[i], E.Exercise1(i));
            }
        }

        [Fact]
        public void Exercise2Test()
        {
            Assert.Equal(new int[0], E.Exercise2(0));
            Assert.Equal(new int[] { 1 }, E.Exercise2(1));
            Assert.Equal(new int[] { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 },
                         E.Exercise2(10));
        }

        [Fact]
        public void Exercise3Test()
        {
            Assert.Equal(new string[0, 0], E.Exercise3(0, 0));
            Assert.Equal(new string[1, 0], E.Exercise3(1, 0));
            Assert.Equal(new string[0, 1], E.Exercise3(0, 1));
            Assert.Equal(new string[,] { { "A1" } }, E.Exercise3(1, 1));
            Assert.Equal(new string[,] { { "A1", "B1", "C1" },
                                         { "A2", "B2", "C2" } },
                         E.Exercise3(2, 3));
        }

        [Fact]
        public void Exercise4Test()
        {
            Assert.Equal(0, E.Exercise4(new int[0]));
            Assert.Equal(1, E.Exercise4(new int[] { 1 }));
            Assert.Equal(2, E.Exercise4(new int[] { -1, 1, 3, 5 }));
        }

        [Fact]
        public void Exercise5Test()
        {
            int testNum = 1;
            for (int i = 0; i < 10; i++)
            {
                if (i > 0) { testNum *= i; }
                Assert.Equal(testNum, E.Exercise5(i));
            }
        }

        [Fact]
        public void Exercise6Test()
        {
            int sum = 0;
            for (int i = 0; i < 10; i++)
            {
                E.Exercise6(ref i, ref sum);
                Assert.Equal(i * (i + 1) / 2, sum);
            }
        }

        [Fact]
        public void Exercise7Test()
        {
            int[] testArr = { 1, 1, 2, 3, 5, 8, 13 };
            Assert.Equal(new int[] { 13, 8, 5, 3, 2, 1, 1 }, E.Exercise7(testArr));
            Assert.Equal(new int[] { 1, 1, 2, 3, 5, 8, 13 }, testArr);
        }

        [Fact]
        public void Exercise8Test()
        {
            int[] testArr = { 1, 1, 2, 3, 5, 8, 13 };
            E.Exercise8(ref testArr);
            Assert.Equal(new int[] { 1, 2, 5, 13 }, testArr);
            E.Exercise8(ref testArr);
            Assert.Equal(new int[] { 1, 5 }, testArr);
            E.Exercise8(ref testArr);
            Assert.Equal(new int[] { 1 }, testArr);
            E.Exercise8(ref testArr);
            Assert.Equal(new int[] { 1 }, testArr);
        }
    }
}
