using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Problem249
{
    class Program
    {
        static void Main(string[] args)
        {
            DateTime start = DateTime.UtcNow;
                UInt64 solution = solution249();                
            DateTime stop = DateTime.UtcNow;
            Console.WriteLine("Answer \t = " + solution.ToString());
            Console.WriteLine("Time \t = " + (stop - start).TotalSeconds.ToString() + "s");

            Console.WriteLine("Press ESC to stop");
            do
            {
                while (!Console.KeyAvailable)
                {
                    // Do something
                }
            } while (Console.ReadKey(true).Key != ConsoleKey.Escape);

            return;
        }

        //Combinations
        private static UInt64[] number_of_compositions_modulo(int M, int[] S)
        {
            List<int> temp = S.ToList();
            temp.Insert(0, 0);
            S = temp.ToArray();
            int N = S.Length;
            M++;
            
            UInt64[][] combinations = new UInt64[2][];
            combinations[0] = new UInt64[M];
            combinations[0][0] = 1;
            combinations[1] = new UInt64[M];
            combinations[1][0] = 1;

            UInt64 d16 = (UInt64)Math.Pow(10, 16);

            int m = 0;
            for (int i = 1; i < N; i++)
            {
                for (int j = 0; j < M; j++)
                {
                    //if (combinations[i-1-m][j] > 0)
                        combinations[i-m][j] = combinations [i-1-m][j];

                    if ((j - S[i] >= 0)) // && combinations[i - 1 - m][j - S[i]] > 0)
                        combinations[i - m][j] = ((combinations[i - m][j] % d16) + (combinations[i - m - 1][j - S[i]] % d16)) % d16;
                }

                combinations[0] = combinations[1]; //copy the second row to the first
                combinations[1] = new UInt64[M];
                combinations[1][0] = 1;
                
                m++;
            }

            return combinations[0];
        }

        //PRIME FUNCTIONS
        private static int[] generate_all_primes_to(int target)
        {
            //BASED ON MATLAB FUNCTION
            //MATLAB input n output p
            //p = 1:2:n;
            //q = length(p);
            //p(1) = 2;
            //for k = 3:2:sqrt(n)
            //  if p((k+1)/2)
            //     p(((k*k+1)/2):k:q) = 0;
            //  end
            //end
            //p = p(p>0);


            List<int> output = new List<int>();

            if (target < 2)
                return output.ToArray();          
            
            for (int i = 1; i <= target; i+=2)
                output.Add(i);

            output[0] = 2;

            for (int k = 3; k <= Math.Sqrt(target); k+= 2)
            {
                if (output[((k+1)/2)-1] != 0)
                {
                    for(int i = ((k*k+1)/2); i < output.Count(); i+= k)
                        output[i-1] = 0;
                }
            }
            output = output.Where(obj => obj > 0).ToList();

            return output.ToArray();
        }
        private static bool is_prime(int number)
        {
            //MATLAB FUNCTION
            //p = primes(ceil(sqrt(n)));
            //for k = 1:numel(isp)
            //   isp(k) = all(rem(X(k), p(p<X(k))));
            //end

            //% p(p<1) would give an empty matrix and all([]) returns true.
            //% we need to correct isp for this case.
            //isp(X==1 | X==0) = false;

            if (number < 2)
                return false;
            
            int[] p = generate_all_primes_to((int)Math.Ceiling((double)number));

            for (int k = 0; k < p.Length; k++)
                if (number == p[k])
                    return true;

            return false;
        }

        private static UInt64 solution249()
        {
            int target = 5000;
            int[] primes = generate_all_primes_to(target);

            //for (int i = 0; i < primes.Length; i++)
            //    Console.WriteLine(primes[i].ToString());

            int sumPrimes = primes.Sum();

            UInt64[] combinations = number_of_compositions_modulo(sumPrimes, primes);
            
            //for (int i = 0; i < combinations.Length; i++)
            //    Console.WriteLine("M="+i.ToString()+" \t possible: "+combinations[i].ToString());

            int[] prime_sums = generate_all_primes_to(sumPrimes);

            UInt64 d16 = (UInt64)Math.Pow(10, 16);
            UInt64 total = 0;
            for (int i = 0; i < prime_sums.Length; i++)
            {
                total = total + combinations[prime_sums[i]] % d16;
                total = total % d16;
            }

            return total;
        }

    }
}
