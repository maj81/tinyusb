CFLAGS += \
  -ffunction-sections \
  -fdata-sections \
  -Wl,--gc-sections \
  -mthumb \
  -mabi=aapcs-linux \
  -mcpu=cortex-m0plus \
  -nostdlib -nostartfiles \
  -D__SAMD21J18A__ \
  -DCONF_DFLL_OVERWRITE_CALIBRATION=0 \
  -DOSC32K_OVERWRITE_CALIBRATION=0 \
  -DCFG_TUSB_MCU=OPT_MCU_SAMD21 \
  -fshort-enums \
  -Os

# All source paths should be relative to the top level.
LD_FILE = hw/bsp/$(BOARD)/samd21j18a_flash.ld

SRC_C += \
	hw/mcu/microchip/samd/asf4/samd21/gcc/gcc/startup_samd21.c \
	hw/mcu/microchip/samd/asf4/samd21/gcc/system_samd21.c \
	hw/mcu/microchip/samd/asf4/samd21/hpl/gclk/hpl_gclk.c \
	hw/mcu/microchip/samd/asf4/samd21/hpl/pm/hpl_pm.c \
	hw/mcu/microchip/samd/asf4/samd21/hpl/sysctrl/hpl_sysctrl.c \
	hw/mcu/microchip/samd/asf4/samd21/hal/src/hal_atomic.c

INC += \
	$(TOP)/hw/mcu/microchip/samd/asf4/samd21/ \
	$(TOP)/hw/mcu/microchip/samd/asf4/samd21/config \
	$(TOP)/hw/mcu/microchip/samd/asf4/samd21/include \
	$(TOP)/hw/mcu/microchip/samd/asf4/samd21/hal/include \
	$(TOP)/hw/mcu/microchip/samd/asf4/samd21/hal/utils/include \
	$(TOP)/hw/mcu/microchip/samd/asf4/samd21/hpl/pm/ \
	$(TOP)/hw/mcu/microchip/samd/asf4/samd21/hpl/port \
	$(TOP)/hw/mcu/microchip/samd/asf4/samd21/hri \
	$(TOP)/hw/mcu/microchip/samd/asf4/samd21/CMSIS/Include

# For TinyUSB port source
VENDOR = microchip
CHIP_FAMILY = samd

# For freeRTOS port source
FREERTOS_PORT = ARM_CM0

# For flash-jlink target
JLINK_DEVICE = ATSAMD21J18
JLINK_IF = swd

# flash using edbg
flash: $(BUILD)/$(BOARD)-firmware.bin
	edbg -b -t samd21 -e -pv -f $<

# flash using jlink
# flash: flash-jlink
