CC = arm-none-eabi-gcc
OBJCOPY = arm-none-eabi-objcopy

STM32_CUBE_ROOT=/Users/toptan/Documents/Fakultet/IR3SP/STM32CubeRoot

CFLAGS = -Wall -mcpu=cortex-m4 -mlittle-endian -mthumb -DSTM32F407xx -Os -nostartfiles
LINKFLAGS = -DSTM32F407xx -T$(STM32_CUBE_ROOT)/Projects/STM32F4-Discovery/Templates/SW4STM32/STM32F4-Discovery/STM32F407VGTx_FLASH.ld -Wl,--gc-sections

INCLUDES += -I/Users/toptan/Documents/Fakultet/IR3SP/STM32CubeRoot/Drivers/CMSIS/Device/ST/STM32F4xx/Include
INCLUDES += -I/Users/toptan/Documents/Fakultet/IR3SP/STM32CubeRoot/Drivers/CMSIS/Include
INCLUDES += -I/Users/toptan/Documents/Fakultet/IR3SP/STM32CubeRoot/Drivers/STM32F4xx_HAL_Driver/Inc

# C sources
SRCS = $(wildcard *.c)
# Adding system initialization code
SRCS += $(STM32_CUBE_ROOT)/Drivers/CMSIS/Device/ST/STM32F4xx/Source/Templates/system_stm32f4xx.c

# Assembler sources
ASMS = $(wildcard *.s)
# Adding startup assembler code
ASMS += $(STM32_CUBE_ROOT)/Drivers/CMSIS/Device/ST/STM32F4xx/Source/Templates/gcc/startup_stm32f407xx.s

TEMP_OBJS = $(SRCS:.c=.o) $(ASMS:.s=.o)
# Let's strip directories from object files
OBJS = $(notdir $(TEMP_OBJS))

MAIN=image.hex

.PHONY: depend clean

all: $(MAIN)

$(MAIN): image.elf
	$(OBJCOPY) -Oihex image.elf $(MAIN)
	@rm *.elf

image.elf: $(OBJS)
	$(CC) $(CFLAGS) $(LINKFLAGS) -o $@ $(OBJS) $(LIBS)

$(OBJS): $(TEMP_OBJS)

.c.o:
	$(CC) $(CFLAGS) $(INCLUDES) -c $<

.s.o:
	$(CC) $(CFLAGS) -c $<

clean:
	rm -f *.o *.elf *.hex
