using System;
using System.Diagnostics;

namespace Probleem_151
{
    class Program
    {
        private static  void    Main(string[] args)
        {
            Stopwatch sw = new Stopwatch();
            sw.Start();
                double answer = CalculateExpectedNumber();
            sw.Stop();

            Console.WriteLine("The expected number of times is: " + answer.ToString("0.000000"));
            Console.WriteLine("The run time is: " + sw.ElapsedMilliseconds.ToString("0.00" + "ms"));
        
            Console.ReadKey();
        }
        
        //Main Functions
        private static  double  CalculateExpectedNumber()
        {       
            //Initial state
            int[] A = new int[6];
            A[0] = 0;
            A[1] = 1;
            A[2] = 0;
            A[3] = 0;
            A[4] = 0;
            A[5] = 0;
            
            int     batch       = 0;
            double  probability = 1.0;
            double  expectation = 0;

            //Recursive function!
            NextBatch((int[])A.Clone(), (batch + 1), 0, probability, ref expectation);

            //Caculate final answer (exclude first and last batch)
            double answer = (expectation - 2.0);
            
            return answer;
        }
        private static  void    NextBatch(int[] A, int batch, double succesSoFar, double probability, ref double expectation)
        {
            //Count amount of sheets in the envelope
            int amount = AmountOfSheets(A);

            if (amount == 0)
            {
                // Add to expectation the number of success times the probability of this path.
                expectation += probability * succesSoFar;
                return;
            }

            if (amount == 1)
                succesSoFar += 1;
            
            for (int i = 1; i < A.Length; i++)
            {
                if (A[i] != 0)
                {
                    //Cut down this Sheet to A5 format
                    int[] temp = CutDownSheetToA5(A, i);

                    //Go to the next batch
                    NextBatch(temp, (batch + 1), succesSoFar, probability * ((double)A[i] / (double)amount), ref expectation);
                }
            }
        }
       
        //Helper Functions
        private static  int[]   CutDownSheetToA5(int[] A, int index)
        {
            int[] output = (int[])A.Clone();

            output[index]--;

            for (int i = (index + 1); i < output.Length; i++)
                output[i]++;

            return output;
        }
        private static  int     AmountOfSheets(int[] A)
        {
            int count = 0;
            for (int i = 0; i < A.Length; i++)
                count += A[i];

            return count;
        }
    }
}
