# 32-point-Radix-2FFT
This is a 32 point pipelined Fast Fourier Transform (FFT) design used in OFDM system. 
The design is based on Radix-2 DIF(decimation-in-frequency) butterfly diagram.

## Usage 
This project include all modules src files written in verilog(HDL language) to run it use any IDE that support verilog like vivado,ISE...etc, Make "Top.v" the top module.
use .... Part or any board with a suitable I/O pins.

## Background
The used algorithm is the Cooley-Tukey algorithm which is the most used FFT algorithm.
to better understand this algorithm please refer to [This link](https://drive.google.com/file/d/1U3t_CRHFbKmovR1XViy5uD87K83ROPB8/view?fbclid=IwAR3BejTsyH2K5CQLWg3risHpfAqPoO7FKlzEzYrO9uKsIp0wusYBYUak7gg). 

## Assumptions
we use this assumptioms in our design:
- FFT block should output 10M samples per second so pipelining clock is 10MHz.
- Clock for the MAC units with frequency 50MHz.
- 32 Samples input to the FFT block are output from an 8-bit ADC which mean that each input is 8 bit .
- Inputs are integers and real only.
- Any Input is represented in sign representation 1 bit for sign and 7 bit for data.
- Any float number (output of any stage) is represented in 22 bit in fixed point representation as follow:
  - 1 bit for sign. 
  - 10 bit for integer ( 3 bit extra for overflow and remainig 7 bits of orginal data).
  - 11 bit for fraction ( you could increse them for better accuracy).
- Outputs is float numbers so it have the same previous representation.
- According to algorithm weights have 16 constant value from 1 to 0 ,so we represent weigths as a fraction number (sign fixed point representation) as follow:
  - 1 bit for sign. 
  - 11 bit for fraction.
you could change most of these assumptions as we made the code generic.

## Design details
According to radix-2 Cooley-Tukey algorithm we need log<sub>2</sub>(32) stages which are 5 stages and to made our design pipelined we place registers between columns in the butterfly diagram.

### FFT diagram
<img src="/FFT%20pic/FFT.png" width="900"/>

As shown in diagram we have 4 main blockes:
### 1. **Reverse:** 
This block is used to arrange the data in the correct order according to Cooley-Tukey algorithm.
### 2. **Register:**<br />
This block used to Store and forward operation data between two FFT stages.
### 3. **Control Unit:**<br />
This block used to control the data flow of the entire design as we need to select.........
### 4. **Stage:**<br />
This block used to evaluate column in butterfly diagram.
Each stage consist of four butterflies:
 
<img src="/FFT%20pic/ButterFly.png" width="900"/>
