public class Solution109
{
   private int[] doubles;
   private int[] triples;
   private int[] singles;

   public Solution109()
   {
       int N = 20; 
       
       doubles = new int[N+1];
       triples = new int[N];
       singles = new int[N+2]; //first element is zero for a miss
       
       for(int i = 0; i < N; i++)
       {
           singles[i+1] = i+1;
           doubles[i] = (i+1)*2;
           triples[i] = (i+1)*3;
       }
       
       singles[singles.length-1] = 25;
       doubles[doubles.length-1] = 50;
}
   
   public int Run()
   {
       int target = 171;       
       int answer = 0; 
       for(int i = 0; i < target; i++)
       {
           answer += computeNumberWaysToFinish(i);
       }
       
       System.out.println("Total number of ways to checkout numbers below: "+target+" = "+answer);
          
       return answer;
   }
   
   private int computeNumberWaysToFinish(int number)
   {
       System.out.println("Number "+Integer.toString(number));
       double numberWays = 0;
       
       String throw1s = "";
       String throw2s = "";
       String throw3s = "";              
       int throw1;
       int throw2;
       int throw3; 
       
       //First Throw
       for(int j = 0; j < (singles.length + triples.length + doubles.length); j++)
       { 
           throw1s = "";
           throw1 = 0;
           
           if(j < singles.length)
           {
               throw1 = singles[j];
               throw1s = "S"+Integer.toString(throw1)+" ";
           }
           else if ((j < singles.length+triples.length))
           {
               throw1 = triples[(j-singles.length)];
               throw1s = "T"+Integer.toString(throw1/3)+" ";
           }
           else
           {
               throw1 = doubles[(j-singles.length-triples.length)];
               throw1s = "D"+Integer.toString(throw1/2)+" ";
           }
           
           //Second Throw
           for(int k = 0; k < (singles.length + triples.length + doubles.length); k++)
           {
               if(k < singles.length)
               {
                   throw2 = singles[k];
                   throw2s = "S"+Integer.toString(throw2)+" ";
               }
               else if ((k < singles.length+triples.length))
               {
                   throw2 = triples[(k-singles.length)];
                   throw2s = "T"+Integer.toString(throw2/3)+" ";
               }
               else
               {
                    throw2 = doubles[(k-singles.length-triples.length)];
                    throw2s = "D"+Integer.toString(throw2/2)+" ";
               }
               
               //Last Throw
               for(int i = 0; i < doubles.length; i++)
               {       
                   if((throw1+throw2+doubles[i]) == number)
                   {                  
                       throw3s = "D"+Integer.toString(doubles[i]/2);
                       //System.out.println(throw1s+throw2s+throw3s);
                       if(throw1s.equals(throw2s))
                            numberWays++;
                       else
                            numberWays+=0.5;
                   }
               }
           }
       }
       
       System.out.println("Number of ways: "+Integer.toString((int)numberWays));
       System.out.println("--------------------------------------");
    
       return (int)numberWays;
   }
}
