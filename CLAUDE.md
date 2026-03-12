# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## LPC4088 Embedded Systems Development - Project Overview

Educational embedded systems library for the **NXP LPC4088** microcontroller (ARM Cortex-M4) used at Universidad de Cádiz. The project provides high-level hardware abstraction layers for the **Embedded Artists LPC4088 Developer's Kit**, supporting courses in Industrial Computing, Microcontroller-Based Automatic Systems, and Microprocessor-Based Design. Targets Keil µVision IDE with ARM Compiler 6. Focus: teaching embedded systems through well-documented, Spanish-named APIs.

**Hardware:** LPC4088 (ARM Cortex-M4F @ 120MHz), 4.3" TFT LCD (480x272, RGB565), 16MB SDRAM, integrated sensors (LM75B temperature), joystick, 4 LEDs, RGB LED.

**Key Projects:** `Librerias/` contains 20+ example projects (`*.uvprojx` for Keil µVision) demonstrating peripherals (GPIO, UART, ADC, DAC, PWM, SPI, I2C, RTC, Timer) and a complete Tetris game implementation.

## Architecture & Structure

### File Organization

- **`Librerias/`** - All source code, libraries, and Keil projects
  - `*_lpc40xx.{h,c}` - Peripheral drivers (GPIO, UART, ADC, I2C, SPI, RTC, Timer, EEPROM)
  - `glcd.{h,c}` + `sdram.{h,c}` - LCD graphics engine with SDRAM frame buffer
  - `main_*.c` - Example programs for each peripheral/feature
  - `*.uvprojx` - Keil µVision 5 project files
  - Game libraries: `bloque`, `cubeta`, `piezas`, `juego`, `marcador`, `menu` (Tetris)
- **`docs/`** - User documentation (INSTALACION.md, LIBRERIAS.md, EJEMPLOS.md, HARDWARE.md)
- **`Referencias/`** - Technical datasheets and reference materials

### Dependency Chain

```
Application Code
    ↓
High-level APIs (leds, joystick, led_rgb, servo_pwm, sonido, lm75b_lpc40xx)
    ↓
Mid-level Drivers (glcd → sdram, adc_lpc40xx, i2c_lpc40xx, etc.)
    ↓
Low-level Drivers (gpio_lpc40xx, iocon_lpc40xx, timer_lpc40xx)
    ↓
CMSIS Headers (LPC407x_8x_177x_8x.h, tipos.h)
    ↓
Hardware Registers
```

**Critical Pattern:** All peripheral libraries follow `modulo_funcion_descriptiva()` snake_case naming with Spanish function names (e.g., `gpio_ajustar_dir()`, `glcd_inicializar()`). This is intentional for educational clarity in Spanish-speaking universities.

## Educational Context

This is a **teaching** repository — clarity beats optimization. When writing or modifying code:

- **Do not** rename or translate Spanish identifiers — they are intentional
- **Do not** merge similar functions — each concept gets its own function
- **Do not** omit Doxygen blocks — explain _why_, not just _what_
- Replace all magic numbers with named constants

## External Dependencies

- **CMSIS**: ARM Cortex-M4 core support (`LPC407x_8x_177x_8x.h`)
- **Hardware**: LPC4088 Developer's Kit with 4.3" LCD, joystick, LEDs
- **No external libs**: Pure register manipulation, no HAL/SDK

## Guías detalladas

- **Contribuciones y Git**: Convenciones de commits, branch naming y workflow → [CONTRIBUTING.md](CONTRIBUTING.md)
- **Estilo de C**: Naming, formatting K&R, declaraciones, spacing → [estiloC.md](estiloC.md)
- **Documentación Doxygen**: Plantillas para archivos, funciones, macros, enums → [docDoxygen.md](docDoxygen.md)
- **Estilo de Ensamblador**: Formato columnar, registros, comentarios ARM → [estiloEnsamblador.md](estiloEnsamblador.md)
- **Testing y Validación**: Verificación en hardware, sin unit tests → [testing.md](testing.md)

**Contact:** alejandro.lara@uca.es (project maintainer)
