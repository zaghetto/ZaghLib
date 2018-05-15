Avsnr version 4:
This program computes the average bit rate or snr difference between two input curves.
The curves are described by four points with SNR values and bit rates.
  
Input data is taken from the file specified from command line:

Syntax:
avsnr <inputfile.txt> 

Syntax input file (curve A and B with four points each, snr.txt is a sample file):

mode
snrA0  snrA1  snrA2  snrA3 
birtA0 bitrA1 bitrA2 bitrA3
snrB0  snrB1  snrB2  snrB3
birtB0 bitrB1 bitrB2 bitrB3

(see snr4.txt for sample input file)

'mode'-> 0=logarithmic mode 1=percentage mode

Output is written to display and to file "log.dat"

Changes from version 3:

- "Sweetpoint" area is removed.
- Percentage mode added
- Use of 3 grade equation, no risk of circular point, and safety mechanism for this is removed  



Software supplied by Telenor Broadband Services  