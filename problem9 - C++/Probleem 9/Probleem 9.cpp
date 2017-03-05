// Probleem 9.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"


int CalculateAnswer(int sum)
{
	int a, b, c;
	
	for (a = 1; a <= sum; a++)
	{
		for (b = 1; b <= sum; b++)
		{
			if (a + b > sum)
				continue;

			for (c = 1; c <= sum; c++)
			{
				if (a*a + b*b == c*c && (a + b + c) == sum)
					return a*b*c;
			}
		}
	}

	return 0;
}

int _tmain(int argc, _TCHAR* argv[])
{
	int sum = 1000;
	int ans = CalculateAnswer(sum);
	
	std::string text = std::to_string(ans);
	std::cout << "The answer is: " << text << "\n";

	std::this_thread::sleep_for(std::chrono::seconds(30));

	return 0;
}
