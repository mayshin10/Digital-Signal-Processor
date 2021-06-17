onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib bufferram_opt

do {wave.do}

view wave
view structure
view signals

do {bufferram.udo}

run -all

quit -force
