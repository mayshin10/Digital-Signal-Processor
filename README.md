
# Digital Signal Processor: </br> three filtering modes

This project is to design a digital signal processor with three filtering modes using FPGA. The FPGA consists of Processing System(PS) and Programmable Logic(PL). Thus, it needs to design hardware and firmware that process images. </br></br>

## Environment
Platform : RPS-z7020-TK </br>
Processor : xc7z020clg484-1 </br>
Design Tool : Vivado Design Suite HLx Edition 19.1 </br></br>

## Image filtering
 The digital signal processor has to meet the following requirements. First of all, it has three filtering modes to process an image; edge, sharp, and blur. Image filtering is implemented through 1-D convolution. Each filtering mode has their convolution coefficient as follow.</br>
```
πΈπππ πΉπππ‘ππβ²π  1π· πππππππππππ‘ = [ β1, β2, 6, β2, β1]  
πhπππ πΉπππ‘ππβ²π  1π· πππππππππππ‘ = [β1, β2, 7, β2, β1] 
π΅ππ’π πΉπππ‘ππβ²π  1π· = [0.1, 0.2, 0.4, 0.2, 0.1] 
```
 The size of the reference image we need to process is 480x272 with 16 bits per one pixel. And the edge of the image will be zero-padded for ease of calculation. It means the value of Reference Image[x] will be zero if x is less than zero or larger than 480*272-1 in the following equation.</br>
 ```
πΉπππ‘ππππ πΌππππ[π] = (πππππ[0] β πππππππππ πΌππππ[π β 2])  + 
                 (πππππ[1] β ππππππππππ πΌππππ[π β 1]) +
                 (πππππ[2] β πππππππππ πΌππππ[π])      +
                 (πππππ[3] β ππππππππ πΌππππ[π + 1])   +
                 (πππππ[4] β ππππππππ πΌππππ[π + 2])
```
 Each RGB value has to calculate separately, and it is handled as zero when it occurs overflow.</br></br>

## Hardware
<p align="center">
<img src = "https://github.com/mayshin10/DSP-FPGA/blob/main/img_src/hardware%20architecture.png" width = "500px" ></br>
Hardware architecture</br></br>
<img src = "https://github.com/mayshin10/DSP-FPGA/blob/main/img_src/system%20wrapper.png" width = "800px" ></br>
System wrapper block diagram</br></br>

</p></br>



## Firmware
<p align="center">
<img src = "https://github.com/mayshin10/DSP-FPGA/blob/main/img_src/firmware%20control.png" width = "500px" ></br>
Firmware control logic</br></br>
</p></br>



## Results
<p align="center">
<img src = "https://github.com/mayshin10/DSP-FPGA/blob/main/img_src/Filtered%20Images.png" width = "600px" ></br>
Filtered Images</br></br>
<img src = "https://github.com/mayshin10/DSP-FPGA/blob/main/img_src/Zynq%20Board%20Results.png" width = "600px" ></br>
Zynq Board results</br></br>

</p></br>
