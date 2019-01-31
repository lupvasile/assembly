# Longest common subsequence

The purpose of this program is to compute and show the longest common subsequence(LCS) between two strings. A subsequence is a sequence that can be derived from another sequence by deleting some elements without changing the order of the remaining elements. For example, the sequence {A,B,D} is a subsequence of {A,B,C,D,E,F} obtained after removal of elements C, E and F.
	One of the strings is located in “data.txt” file and the other is entered by the user at the program run. The maximum number of characters of a string is 100. If the string in “data.txt” has more than 100 characters, only the first 100 characters will be used.

## Program operation:
•	the user opens the program
•	the user is asked if he wants the program to be case-sensitive or case-insensitive. If the program is case-insensitive, then “abecd” and “ABCD” will have the same LCS as “ABECD” and “ABCD”
•	the user must press 1 (for case sensitive) and 2 (for case insensitive). Any different input is rejected.
•	the user is asked to enter(using the keyboard) the string he wants to be compared with the string from the file. The user is informed about the max length of the entered string.
•	When the string entering is done, the user must press Enter to start computing the longest common subsequence between his string and the string in file.
If the user reaches maximum number of characters, he is informed that following characters are discarded and the program starts execution automatically.
•	the LCS  is computed and the length of the substring is displayed. Also, LCS  is displayed. If the user chose case-insensitive, then the substring displayed is all with Uppercase letters.

## Method/Algorithm used
	To compute LCS, dynamic programming is used. Let A be the first string, B be the second string and DYN be the matrix.
DYN[x,y] = the maximum length of a common subsequence using first x characters of A and first y characters of B. Then, if A[x] is equal to B[y], DYN[x,y] = 1 + DYN[x-1,y-1]. If A[x] is different from B[y], DYN[x,y] = max(DYN[x,y-1],DYN[x-1,y]). If x or y is 0, DYN[x,y] = 0.
In the same time, we can build another matrix used to reconstruct the LCS, Father.
Father[x,y] = the cell we used to obtain DYN[x,y]. (it may be [x-1,y-1],[x,y-1] or [x-1,y]).
In the end, the length of the LCS is in DYN[length(A),length(B)]. To reconstruct the LCS, we start from bottom right cell of Father and make our way back to cell [0,0]. If we are on Father[x,y] and A[x] is equal to B[y], then character A[x] will be in the result.
