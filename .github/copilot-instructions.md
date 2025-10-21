# LPC4088 Embedded Systems Development - AI Agent Guide

## Project Overview

Educational embedded systems library for the **NXP LPC4088** microcontroller (ARM Cortex-M4) used at Universidad de Cádiz. The project provides high-level hardware abstraction layers for the **Embedded Artists LPC4088 Developer's Kit**, supporting courses in Industrial Computing, Microcontroller-Based Automatic Systems, and Microprocessor-Based Design.

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

**Critical Pattern:** All peripheral libraries follow `MODULO_FuncionDescriptiva()` naming with Spanish function names (e.g., `gpio_ajustar_dir()`, `glcd_inicializar()`). This is intentional for educational clarity in Spanish-speaking universities.

## Development Workflow

### Git Branch Naming Conventions
Always use these branch prefixes when creating new branches:
- `feature/descripcion` - For new features (e.g., `feature/nueva-libreria-dac`)
- `fix/descripcion` - For bug fixes (e.g., `fix/corregir-error-uart`)
- `docs/descripcion` - For documentation changes (e.g., `docs/actualizar-readme`)
- `refactor/descripcion` - For code refactoring (e.g., `refactor/optimizar-glcd`)

### Commit Message Conventions
Follow these commit type prefixes (Conventional Commits style):
- `feat:` - New feature (e.g., `feat: añadir soporte para DAC`)
- `fix:` - Bug fix (e.g., `fix: corregir baudrate UART0`)
- `docs:` - Documentation changes (e.g., `docs: actualizar ejemplos ADC`)
- `style:` - Code style/formatting (e.g., `style: ajustar indentación`)
- `refactor:` - Code refactoring (e.g., `refactor: simplificar inicialización LCD`)
- `test:` - Adding tests (e.g., `test: añadir pruebas GPIO`)
- `chore:` - Maintenance tasks (e.g., `chore: actualizar configuración Keil`)

**Commit format:**
```
tipo: Descripción breve

Descripción más detallada si es necesaria.

Fixes #123
```

### Building & Testing
1. **Primary IDE:** Keil µVision 5.38+ with ARM Compiler 6
2. **Workspace:** Open `Librerias/00_Librerias.uvmpw` (multi-project workspace)
3. **Build:** F7 (Project → Build Target)
4. **Flash:** F8 (Flash → Download) via CMSIS-DAP debugger
5. **Debug:** Ctrl+F5 (Debug → Start/Stop Session), F5 to run
6. **No makefiles/CMake** - Pure Keil project structure

### Creating New Projects
- **Base template:** Copy `02_Base.uvprojx` structure
- **Must include:**
  - Device: NXP LPC4088FBD208
  - Include paths: `.\`, `.\Librerias`
  - Startup file: `startup_LPC407x_8x_177x_8x.s`
  - System file: `system_LPC407x_8x_177x_8x.c`
  - Core clock: 120 MHz (configured via `SystemCoreClockUpdate()`)
- See `docs/INSTALACION.md` for detailed project setup

### Pull Request Workflow
When creating PRs, include in description:
- **Type of change** checklist (bug fix, new feature, breaking change, documentation)
- **Testing performed** on actual hardware
- **Compatibility verification** with existing examples
- **Documentation updates** (README.md, docs/LIBRERIAS.md, docs/EJEMPLOS.md)
- Reference related issues using `Closes #N` or `Fixes #N`

### Testing Approach
- **No automated tests** - All validation is manual on physical hardware
- Every change MUST be tested on LPC4088 Developer's Kit
- Serial output via UART0 (115200 baud) for debug messages
- Visual feedback via LCD and 4 LEDs for immediate verification

## Coding Conventions (CRITICAL)

### Style Guide Reference
Follow **"Programación en C - Guía de Estilo.pdf"** in repository root. Key rules:

#### Naming Conventions
- **Functions:** `MODULO_funcion_descriptiva()` (Spanish names) - e.g., `gpio_ajustar_dir()`, `timer_retardo_ms()`
- **Variables:** `snake_case` (Spanish) - `contador_actual`, `temperatura_ambiente`
- **Global variables:** `g_` prefix - `g_flag_timer`, `g_valor_adc`
- **Constants/Macros:** `UPPER_SNAKE_CASE` - `LED_PIN`, `BUFFER_SIZE`, `GLCD_TAMANO_X`
- **Types:** `PascalCase_t` - `RTC_FechaHora_t`, `Pieza_t`, `bool_t`
- **Enums:** `PREFIJO_VALOR` - `JOYSTICK_CENTRO`, `DIR_ENTRADA`, `COLOR_ROJO`

#### Formatting (K&R Style)
```c
// Opening brace on same line, blank line after opening brace
void funcion(uint32_t parametro) {

  uint32_t variable_local = 0;
  
  if (condicion) {
    // código
  } else {
    // código alternativo
  }
}

// 2 SPACES for indentation (NO TABS)
// Spaces around operators: x = y + z;
// No space before function parentheses: funcion(param);
// Space after keywords: if (cond), while (cond), for (i = 0; ...)
// Max 100 chars per line
```

#### Documentation (Doxygen)
```c
/**
 * @file    archivo.c
 * @brief   Descripción breve.
 *
 * Descripción detallada del propósito del archivo.
 *
 * @author  Nombre - email@uca.es
 * @date    2025
 * @version 2.0
 *
 * @copyright GNU General Public License version 3 or later
 */

/**
 * @brief   Descripción breve de la función.
 * @ingroup MODULO
 *
 * Descripción detallada del comportamiento.
 *
 * @param[in]  param1  Descripción del parámetro.
 * @param[out] param2  Descripción del parámetro de salida.
 * @return  Descripción del valor retornado.
 *
 * @note    Notas importantes.
 * @warning Advertencias críticas.
 */
```

### Hardware-Specific Patterns

#### LCD Graphics (glcd.h)
- Frame buffer at `SDRAM_BASE + 0x0010000` (must initialize SDRAM first!)
- Always call `glcd_inicializar()` before any graphics operations
- Colors in RGB565 format: `(R5<<11) | (G6<<5) | B5`
- Coordinate system: (0,0) = top-left, (479, 271) = bottom-right
- Use `glcd_xprintf()` for formatted text output (like printf)

#### Interrupt Handling Pattern
```c
// In main():
NVIC_ClearPendingIRQ(TIMER0_IRQn);
NVIC_SetPriority(TIMER0_IRQn, 1);  // Lower number = higher priority
NVIC_EnableIRQ(TIMER0_IRQn);
__enable_irq();  // Enable global interrupts

// ISR function (must match name exactly):
void TIMER0_IRQHandler(void) {

  // ... handle interrupt ...
  
  TIMER0->IR = 1;  // Clear interrupt flag (CRITICAL!)
}
```

#### GPIO Pattern
```c
// Use PORT macros, not direct register access
gpio_ajustar_dir(PUERTO1, PIN18, DIR_SALIDA);  // NOT LPC_GPIO1
gpio_pin_a_1(PUERTO1, PIN18);  // Set high
gpio_pin_a_0(PUERTO1, PIN18);  // Set low
bool_t estado = gpio_leer_pin(PUERTO1, PIN18);
```

#### Pin Multiplexing (IOCON)
Every peripheral requires IOCON configuration before use:
```c
// Example for UART0 TX (P0.2)
LPC_IOCON->P0_2 = 1;  // Function 1 = UART0_TXD
// See datasheet for function numbers per pin
```

## Common Pitfalls & Solutions

1. **LCD shows nothing:** Did you call `sdram_inicializar()` BEFORE `glcd_inicializar()`?
2. **UART not working:** Check IOCON pin configuration AND baudrate calculation (depends on PCLK)
3. **Timer frequency wrong:** Verify `SystemCoreClock` is updated via `SystemCoreClockUpdate()`
4. **Peripheral not responding:** Enable peripheral clock in PCONP register before configuration
5. **Joystick reads wrong:** It uses ADC - initialize ADC before joystick
6. **Compilation warnings:** Never ignore warnings - fix all before testing on hardware

## Educational Context

This is for **teaching**, so code prioritizes **clarity over optimization**:
- Descriptive Spanish variable names are intentional
- Separate functions for each concept, even if similar
- Extensive Doxygen comments explaining "why" not just "what"
- Magic numbers replaced with named constants
- Error checking with `ASSERT()` macro (defined in error.h)

When adding features:
- Provide example in `main_*.c` format
- Document in `docs/LIBRERIAS.md` and `docs/EJEMPLOS.md`
- Follow existing peripheral library structure
- Add Doxygen `@ingroup` tags for organization

## Quick Reference

**Pin Definitions (from schematics):**
- LED1: P1.18, LED2: P0.13, LED3: P1.13, LED4: P2.19
- Joystick: P2.25 (UP), P2.27 (DOWN), P2.23 (LEFT), P2.26 (RIGHT), ADC0.0 (CENTER)
- UART0: P0.2 (TX), P0.3 (RX)
- I2C0: P0.27 (SDA), P0.28 (SCL) - LM75B at 0x48

**Repository Files:**
- `CONTRIBUTING.md` - Full coding standards
- `docs/INSTALACION.md` - Development environment setup
- `docs/LIBRERIAS.md` - Complete API reference
- `Programación en C - Guía de Estilo.pdf` - Official C style guide (Spanish)

**Contact:** alejandro.lara@uca.es (project maintainer)
