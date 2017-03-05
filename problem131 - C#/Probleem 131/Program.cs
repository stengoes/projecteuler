using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Probleem_131
{
    class Program
    {
        static void Main(string[] args)
        {
            DateTime start = DateTime.UtcNow;
                int solution = solution131();
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

            for (int i = 1; i <= target; i += 2)
                output.Add(i);

            output[0] = 2;

            for (int k = 3; k <= Math.Sqrt(target); k += 2)
            {
                if (output[((k + 1) / 2) - 1] != 0)
                {
                    for (int i = ((k * k + 1) / 2); i < output.Count(); i += k)
                        output[i - 1] = 0;
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

        private static int solution131()
        {
            int total = 0;
            for (int i = 1; i < 577; i++)
            {
                int p = ((i + 1) * (i + 1) * (i + 1) - (i * i * i));
                if (is_prime(p))
                {
                    int n = i*i*i;
                    int k = n * n * n + n * n * p;

                    Console.WriteLine("p = " + p + " n = " + n + " k = " + k);

                    total++;
                }
            }
            return total;
        }
    }
}
