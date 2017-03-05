using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Probleem_206
{
    class Program
    {
        static void Main(string[] args)
        {
            DateTime start = DateTime.UtcNow;
                UInt64 answer = Solution206();
            DateTime stop = DateTime.UtcNow;
   
            Console.WriteLine("The answer is: "+answer.ToString());
            Console.WriteLine("Time = "+(stop-start).TotalSeconds.ToString()+"s");

            Console.WriteLine("Press ESC to stop");
            do
            {
                while (!Console.KeyAvailable)
                {
                    // Do something
                }
            } while (Console.ReadKey(true).Key != ConsoleKey.Escape);
        }

        public static UInt64 Solution206()
        {
            UInt64 xStart = 1020304050607080900;

            UInt64 x = xStart;
            UInt64 answer = 0;

            while (x <= 1999999999999999990)
            {
                UInt64 d0 = 0;
                    for (UInt64 d9 = 0; d9 < 1000000000000000000; d9 += 100000000000000000)
                    {
                        for (UInt64 d8 = 0; d8 < 10000000000000000; d8 += 1000000000000000)
                        {
                            for (UInt64 d7 = 0; d7 < 100000000000000; d7 += 10000000000000)
                            {
                                for (UInt64 d6 = 0; d6 < 1000000000000; d6 += 100000000000)
                                {
                                    for (UInt64 d5 = 0; d5 < 10000000000; d5 += 1000000000)
                                    {
                                        for (UInt64 d4 = 0; d4 < 100000000; d4 += 10000000)
                                        {
                                            for (UInt64 d3 = 0; d3 < 1000000; d3 += 100000)
                                            {
                                                for (UInt64 d2 = 0; d2 < 10000; d2 += 1000)
                                                {
                                                    for (UInt64 d1 = 0; d1 < 100; d1 += 10)
                                                    {
                                                        x = xStart + d1 + d2 + d3 + d4 + d5 + d6 + d7 + d8 + d9 + d0;

                                                        answer = compute_sqrt(x);

                                                        UInt64 temp = ((UInt64)(answer) * (UInt64)(answer));
                                                        if (x == temp)
                                                        {
                                                            //Console.WriteLine("Found an Answer: "+((UInt64)answer).ToString());
                                                            return answer;
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

            return (UInt64)answer;
        }

        static UInt64 compute_sqrt(UInt64 num)
        {
            UInt64 res = 0;
            UInt64 bit = ((UInt64)1 << 62); // The second-to-top bit is set: 1 << 30 for 32 bits

            // "bit" starts at the highest power of four <= the argument.
            while (bit > num)
                bit >>= 2;

            while (bit != 0)
            {
                if (num >= res + bit)
                {
                    num -= res + bit;
                    res = (res >> 1) + bit;
                }
                else
                    res >>= 1;
                bit >>= 2;
            }
            return res;
        }
    }
}
