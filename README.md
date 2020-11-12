# MVP:Matrix-vector multiplication implemented on PYNQ board
# Introduction

There are a huge number of ***Matrix-Vector Multiplication***  operations in deep learning and it's of great importance to accelerate this process.

Both activation and weight are quantified into **4 bit**.(the MSB is the signal bit)

A bit serial method is adopted to complete the MAC operation and it can greatly reduce power consumption compared to tradtional method.
![architecture](./picture/pic_1.jpg)
# Architecture
![architecture](./picture/pic_2.jpg)
Note that DMA is used to move weigth and activation from.
Of course you can also use .coe to load the data into BRAM.
 
# Block Design 
![architecture](./picture/pic_3.jpg)

# Acknowledgement
This project is based on LEMON,which is completed by @zhuiyuanjiao@zhutmost.