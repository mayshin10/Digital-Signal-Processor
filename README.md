
# Digital Signal Processor: </br> three filtering modes

This project is to design a digital signal processor with three filtering modes; edge, sharp and blur.</br>

## Environment
Platform : RPS-z7020-TK </br>
Processor : xc7z020clg484-1 </br>
Design Tool : Vivado Design Suite HLx Edition 19.1 </br> 

## Image filtering
 The digital signal processor has to meet the following requirements. First of all, it has three filtering modes to process an image; edge, sharp, and blur. Image filtering is implemented through 1-D convolution. Each filtering mode has their convolution coefficient as follow.</br>
```
𝐸𝑑𝑔𝑒 𝐹𝑖𝑙𝑡𝑒𝑟′𝑠 1𝐷 𝑐𝑜𝑒𝑓𝑓𝑖𝑐𝑖𝑒𝑛𝑡 = [ −1, −2, 6, −2, −1]  
𝑆h𝑎𝑟𝑝 𝐹𝑖𝑙𝑡𝑒𝑟′𝑠 1𝐷 𝑐𝑜𝑒𝑓𝑓𝑖𝑐𝑖𝑒𝑛𝑡 = [−1, −2, 7, −2, −1] 
𝐵𝑙𝑢𝑟 𝐹𝑖𝑙𝑡𝑒𝑟′𝑠 1𝐷 = [0.1, 0.2, 0.4, 0.2, 0.1] 
```
 The size of the reference image we need to process is 480x272 with 16 bits per one pixel. And the edge of the image will be zero-padded for ease of calculation. It means the value of Reference Image[x] will be zero if x is less than zero or larger than 480*272-1 in the following equation.</br>
 ```
𝐹𝑖𝑙𝑡𝑒𝑟𝑒𝑑 𝐼𝑚𝑎𝑔𝑒[𝑖] = (𝑐𝑜𝑒𝑓𝑓[0] ∗ 𝑅𝑒𝑓𝑒𝑟𝑒𝑛𝑐𝑒 𝐼𝑚𝑎𝑔𝑒[𝑖 − 2])  + 
                 (𝑐𝑜𝑒𝑓𝑓[1] ∗ 𝑅𝑒𝑓𝑒𝑟𝑒𝑐𝑛𝑐𝑒 𝐼𝑚𝑎𝑔𝑒[𝑖 − 1]) +
                 (𝑐𝑜𝑒𝑓𝑓[2] ∗ 𝑅𝑒𝑓𝑒𝑟𝑒𝑛𝑐𝑒 𝐼𝑚𝑎𝑔𝑒[𝑖])      +
                 (𝑐𝑜𝑒𝑓𝑓[3] ∗ 𝑅𝑒𝑓𝑒𝑟𝑒𝑐𝑒 𝐼𝑚𝑎𝑔𝑒[𝑖 + 1])   +
                 (𝑐𝑜𝑒𝑓𝑓[4] ∗ 𝑅𝑒𝑓𝑒𝑟𝑒𝑐𝑒 𝐼𝑚𝑎𝑔𝑒[𝑖 + 2])
```
 Each RGB value has to calculate separately, and it is handled as zero when it occurs overflow.</br>

## Hardware
<p align="center">
<img src = "https://github.com/mayshin10/DSP-FPGA/blob/main/img_src/hardware%20architecture.png" width = "500px" ></br></br>
Hardware architecture</br>
<img src = "https://github.com/mayshin10/DSP-FPGA/blob/main/img_src/system%20wrapper.png" width = "800px" ></br>
System wrapper block diagram</br></br>

</p></br>

---

## Firmware
<p align="center">
<img src = "https://github.com/mayshin10/DSP-FPGA/blob/main/img_src/firmware%20control.png" width = "500px" ></br>
Firmware control logic</br></br>
</p></br>

---

## Results
잆럮햕 뮩쨩읉 햕뀪읹먅 얉야뾽 쓔 있꼐 뼍얶햬뜲릾니땨.</br>
여가러지 옵션이 있요어! </br></br>
<p align="center">
<img src = "https://user-images.githubusercontent.com/45932570/116428680-1b2ac480-a880-11eb-86e3-5af8c7914589.jpg"></br>
<i>윴튜쁪 떘끑 왠뀪읹뜳이 묫얉야뾰껥 햐끼</i>
</p></br>
