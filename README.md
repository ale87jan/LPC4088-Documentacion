<!-- LICENSE INFORMATION
Copyright (C) 2025 Alejandro Lara Doña
Permission is granted to copy, distribute and/or modify this document
under the terms of the GNU Free Documentation License, Version 1.3
or any later version published by the Free Software Foundation;
with no Invariant Sections, no Front-Cover Texts, and no Back-Cover Texts.
A copy of the license is included in the section entitled "GNU
Free Documentation License".
-->

# Documentación LPC4088

<div align="center">

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![Universidad de Cádiz](https://img.shields.io/badge/Universidad-de%20C%C3%A1diz-blue)](https://www.uca.es/)

</div>

## 📋 Descripción

Este repositorio contiene la **documentación y librerías** desarrolladas para el microcontrolador **NXP LPC4088** utilizando la tarjeta **Embedded Artists LPC4088 Developer's Kit**. Las librerías están diseñadas para facilitar el aprendizaje y desarrollo de aplicaciones embebidas, proporcionando una interfaz de alto nivel para acceder a los periféricos del microcontrolador.

### 🎓 Uso Académico

Estas librerías se utilizan en la docencia de las siguientes asignaturas en la **Universidad de Cádiz**:

- **Grado en Ingeniería Electrónica Industrial**
  - Informática Industrial
  - Sistemas Automáticos Basados en Microcontrolador
  
- **Grado en Ingeniería Informática**
  - Diseño Basado en Microprocesadores

## ✨ Características Principales

- 📚 Librerías optimizadas para el LPC4088 (ARM Cortex-M4)
- 🎮 Soporte para pantalla LCD táctil de 4.3"
- 🔌 Drivers para múltiples periféricos (UART, SPI, I2C, ADC, DAC, PWM, RTC)
- 📊 Ejemplos prácticos y proyectos completos
- 📖 Documentación generada con Doxygen
- 🎯 Código educativo y bien comentado
- 🎨 Proyecto de ejemplo: Tetris completo

## 🗂️ Estructura del Repositorio

```none
LPC4088-Documentacion/
│
├── Documentacion LPC4088/     # Documentación técnica oficial
│   ├── ARM/                   # Documentación de ARM
│   ├── NXP/                   # Documentación del fabricante
│   ├── Embedded Artists/      # Documentación de la tarjeta
│   └── Libros Referencia/     # Material de referencia
│
├── Librerias/                 # Código fuente de las librerías
│   ├── *_lpc40xx.h/.c        # Drivers de periféricos
│   ├── glcd.h/.c             # Librería gráfica LCD
│   ├── main_*.c              # Ejemplos de uso
│   └── *.uvprojx             # Proyectos Keil µVision
│
├── docs/                      # Documentación adicional
│   ├── HARDWARE.md           # Información sobre el hardware
│   ├── LIBRERIAS.md          # Documentación de librerías
│   ├── EJEMPLOS.md           # Guía de ejemplos
│   └── INSTALACION.md        # Guía de instalación
└── CONTRIBUTING.md           # Guía de contribución
```

## 🚀 Inicio Rápido

### Requisitos Previos

- **Hardware:**
  - Embedded Artists LPC4088 Developer's Kit
  - Cable USB para programación y depuración
  - (Opcional) Sensores y actuadores según el proyecto

- **Software:**
  - Keil µVision 5 o superior
  - ARM Compiler 6
  - Drivers J-Link para depuración
  - (Opcional) Doxygen para generar documentación

### Instalación

Consulta la [Guía de Instalación](docs/INSTALACION.md) para instrucciones detalladas.

1. Clona el repositorio:

   ```bash
   git clone https://github.com/ale87jan/LPC4088-Documentacion.git
   ```

2. Abre el workspace principal con Keil µVision:

   ```none
   Librerias/00_Librerias.uvmpw
   ```

3. Selecciona uno de los proyectos de ejemplo

4. Compila y programa el microcontrolador

## 📚 Documentación

- **[Documentación de Hardware](docs/HARDWARE.md)** - Información sobre el LPC4088 y la Developer's Kit
- **[Librerías Disponibles](docs/LIBRERIAS.md)** - Referencia completa de todas las librerías
- **[Ejemplos de Código](docs/EJEMPLOS.md)** - Guía de los proyectos de ejemplo
- **[Guía de Instalación](docs/INSTALACION.md)** - Configuración del entorno de desarrollo
- **[Guía de Contribución](CONTRIBUTING.md)** - Cómo contribuir al proyecto

## 🔧 Periféricos Soportados

| Periférico | Librería | Descripción |
|------------|----------|-------------|
| GPIO | `gpio_lpc40xx` | Control de entradas/salidas digitales |
| UART | `uart_lpc40xx` | Comunicación serie asíncrona |
| ADC | `adc_lpc40xx` | Conversión analógico-digital |
| DAC | `dac_lpc40xx` | Conversión digital-analógico |
| PWM | `pwm_lpc40xx` | Modulación por ancho de pulso |
| SPI | `spi_lpc40xx` | Comunicación serie síncrona |
| I2C | `i2c_lpc40xx` | Bus de comunicación I2C |
| RTC | `rtc_lpc40xx` | Reloj de tiempo real |
| Timer | `timer_lpc40xx` | Temporizadores de propósito general |
| LCD | `glcd` | Pantalla gráfica de 4.3" |
| EEPROM | `eeprom_lpc40xx` | Memoria EEPROM interna |

## 🎮 Ejemplos Incluidos

- **01_GLCD** - Introducción a la pantalla LCD
- **02_Base** - Proyecto base con timer y joystick
- **02.1_Tetris** - Juego Tetris completo
- **04_ADC** - Conversión analógico-digital
- **05_UART** - Comunicación serie
- **06_PWM** - Control de servo y LED RGB
- **07_RTC** - Reloj en tiempo real
- **08_SPI** - Comunicación SPI
- **09_I2C** - Temperatura con sensor LM75B
- Y más...

Ver [EJEMPLOS.md](docs/EJEMPLOS.md) para información detallada.

## 👥 Autores

### Alejandro Lara Doña

- Profesor de la Universidad de Cádiz
- Email: [alejandro.lara@uca.es](mailto:alejandro.lara@uca.es)
- [Perfil Investigador](https://produccioncientifica.uca.es/investigadores/120262/detalle)

### Reconocimientos

Estas librerías se basan en el trabajo previo desarrollado por:

- **Eduardo Romero Bruzón** - Profesor UCA
- **Victor Manuel Sánchez Corbacho** - Profesor UCA

Ambos desarrollaron las librerías originales para la versión 5 del compilador de ARM.

## 📄 Licencia

Este proyecto está licenciado bajo la **GNU General Public License v3.0** - ver el archivo [LICENSE.md](LICENSE.md) para más detalles.

La documentación está licenciada bajo la **GNU Free Documentation License v1.3** o posterior.

## 🔗 Enlaces de Interés

### Universidad de Cádiz

- [Universidad de Cádiz](https://www.uca.es/)
- [Escuela Superior de Ingeniería](https://esingenieria.uca.es/)

### Recursos Técnicos

- [NXP LPC40xx Product Page](https://www.nxp.com/products/processors-and-microcontrollers/arm-microcontrollers/general-purpose-mcus/lpc4000-arm-cortex-m4/scalable-entry-level-32-bit-microcontroller-mcu-based-on-arm-cortex-m4-core:LPC408X_7X)
- [Embedded Artists LPC4088 Developer's Kit](https://www.embeddedartists.com/products/lpc4088-developer-kit/)
- [ARM Keil µVision](https://www.keil.com/uvision/)
- [Documentación Doxygen](https://www.doxygen.nl/)

## 🤝 Contribuciones

Las contribuciones son bienvenidas. Por favor, lee la [Guía de Contribución](CONTRIBUTING.md) antes de enviar un Pull Request.

## 📧 Contacto

Para preguntas o sugerencias, contacta a través de:

- Email institucional: [alejandro.lara@uca.es](mailto:alejandro.lara@uca.es)
- Issues de GitHub: [Crear un issue](https://github.com/ale87jan/LPC4088-Documentacion/issues)

## 🔖 Versión

**Versión 2.0** - Actualizado para ARM Compiler 6 (2025)

---

<div align="center">
<!-- markdownlint-disable-next-line -->
**Desarrollado con ❤️ para la comunidad educativa de la Universidad de Cádiz**

</div>
