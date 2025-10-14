<!-- LICENSE INFORMATION
Copyright (C) 2025 Alejandro Lara Doña
Permission is granted to copy, distribute and/or modify this document
under the terms of the GNU Free Documentation License, Version 1.3
or any later version published by the Free Software Foundation;
with no Invariant Sections, no Front-Cover Texts, and no Back-Cover Texts.
A copy of the license is included in the section entitled "GNU
Free Documentation License".
-->

<!-- markdownlint-disable MD024 -->

# Guía de Contribución

## 🤝 Bienvenido

¡Gracias por tu interés en contribuir al proyecto LPC4088-Documentacion! Este documento proporciona pautas y mejores prácticas para contribuir al proyecto.

## 📋 Tabla de Contenidos

- [Código de Conducta](#código-de-conducta)
- [Cómo Contribuir](#cómo-contribuir)
- [Reportar Errores](#reportar-errores)
- [Sugerir Mejoras](#sugerir-mejoras)
- [Proceso de Pull Request](#proceso-de-pull-request)
- [Guía de estilo](#guía-de-estilo)
- [Documentación](#documentación)
- [Preguntas Frecuentes](#preguntas-frecuentes)

## Código de Conducta

Este proyecto se adhiere a principios de respeto y colaboración. Se espera que todos los contribuyentes:

- Sean respetuosos con otros contribuyentes
- Acepten críticas constructivas
- Se enfoquen en lo que es mejor para el proyecto educativo
- Mantengan un ambiente acogedor para estudiantes y educadores

## Cómo Contribuir

Hay muchas formas de contribuir a este proyecto:

### 1. Mejorar la Documentación

- Corregir errores ortográficos o gramaticales
- Aclarar explicaciones confusas
- Añadir ejemplos adicionales
- Traducir documentación
- Mejorar comentarios en el código

### 2. Reportar Errores

- Errores en el código
- Problemas de compilación
- Comportamiento inesperado
- Errores en la documentación

### 3. Proponer Nuevas Características

- Nuevas librerías para periféricos
- Nuevos ejemplos educativos
- Mejoras en las librerías existentes
- Optimizaciones de código

### 4. Contribuir Código

- Corregir bugs
- Implementar nuevas características
- Optimizar código existente
- Añadir tests

## Reportar Errores

### Antes de Reportar

1. **Verifica que sea realmente un error**
   - Revisa la documentación
   - Verifica que estés usando la versión correcta
   - Asegúrate de que el hardware esté correctamente conectado

2. **Busca si ya fue reportado**
   - Revisa los [Issues](https://github.com/ale87jan/LPC4088-Documentacion/issues) existentes
   - Incluye issues cerrados en tu búsqueda

### Crear un Issue

Usa la siguiente plantilla cuando reportes un error:

```markdown
## Descripción del Error

[Descripción clara y concisa del error]

## Para Reproducir

Pasos para reproducir el comportamiento:
1. Compilar proyecto '...'
2. Ejecutar función '...'
3. Observar error '...'

## Comportamiento Esperado

[Descripción de lo que debería ocurrir]

## Comportamiento Actual

[Descripción de lo que realmente ocurre]

## Capturas de Pantalla

[Si aplica, añade capturas]

## Entorno

- Versión de Keil µVision: [ej. 5.39]
- Versión del compilador ARM: [ej. 6.19]
- Sistema Operativo: [ej. Windows 11]
- Hardware: [ej. LPC4088 Developer's Kit Rev. X]

## Código Relevante

~~~c
// Pega aquí el código relevante
~~~

## Información Adicional

[Cualquier otra información relevante]

```

## Sugerir Mejoras

### Feature Requests

Usa esta plantilla para sugerencias:

```markdown
## Descripción de la Característica
[Descripción clara y concisa de la característica deseada]

## Motivación
[¿Por qué sería útil esta característica?]

## Solución Propuesta
[Descripción de cómo debería funcionar]

## Alternativas Consideradas
[Otras formas de lograr el mismo objetivo]

## Contexto Educativo
[¿Cómo beneficiaría esto a los estudiantes?]

## Información Adicional
[Cualquier otra información relevante]
```

## Proceso de Pull Request

### 1. Fork y Clone

```bash
# Fork el repositorio en GitHub, luego:
git clone https://github.com/TU-USUARIO/LPC4088-Documentacion.git
cd LPC4088-Documentacion
```

### 2. Crear una Rama

```bash
# Crea una rama descriptiva
git checkout -b feature/nueva-libreria-xyz
# o
git checkout -b fix/corregir-error-uart
```

Convenciones de nombres de ramas:

- `feature/descripcion` - Para nuevas características
- `fix/descripcion` - Para correcciones de bugs
- `docs/descripcion` - Para cambios en documentación
- `refactor/descripcion` - Para refactorización de código

### 3. Hacer Cambios

- Sigue los [Estándares de Código](#guía-de-estilo)
- Documenta tu código apropiadamente
- Prueba tus cambios exhaustivamente
- Mantén los commits pequeños y enfocados

### 4. Commit

```bash
git add .
git commit -m "Tipo: Descripción breve

Descripción más detallada si es necesaria.

Fixes #123"
```

Tipos de commit:

- `feat:` - Nueva característica
- `fix:` - Corrección de bug
- `docs:` - Cambios en documentación
- `style:` - Formato, punto y coma faltantes, etc.
- `refactor:` - Refactorización de código
- `test:` - Añadir tests
- `chore:` - Mantenimiento

### 5. Push y Pull Request

```bash
git push origin feature/nueva-libreria-xyz
```

Luego crea un Pull Request en GitHub con:

- **Título descriptivo**
- **Descripción detallada** de los cambios
- **Referencias** a issues relacionados
- **Capturas** si aplica
- **Checklist** de verificación

#### Plantilla de Pull Request

```markdown
## Descripción
[Descripción de los cambios realizados]

## Tipo de Cambio
- [ ] Corrección de bug
- [ ] Nueva característica
- [ ] Breaking change
- [ ] Documentación

## ¿Cómo se ha Probado?
[Describe las pruebas realizadas]

## Checklist
- [ ] Mi código sigue las convenciones del proyecto
- [ ] He comentado mi código adecuadamente
- [ ] He actualizado la documentación correspondiente
- [ ] Mis cambios no generan nuevas advertencias
- [ ] He probado en hardware real
- [ ] Los cambios son compatibles con el código existente

## Issues Relacionados
Closes #123
Fixes #456

## Capturas (si aplica)
```

## Guía de estilo

### Formato de Código

#### Indentación

- **2 espacios** (no tabs)
- Configurar el editor para convertir tabs en espacios
- Mantener consistencia en todo el código

#### Llaves

```c
// Llave de apertura en la misma línea (estilo K&R para todo)
void funcion(void) {

  // Línea en blanco después de la llave de apertura
  if (condicion) {
    // código
  } else {
    // código alternativo
  }
}

// Para funciones también se aplica el mismo estilo
void otra_funcion(uint32_t parametro) {

  // Línea en blanco después de la llave de apertura
  uint32_t variable_local = 0;
  
  // código...
}
```

#### Espaciado

```c
// Espacios alrededor de operadores
x = y + z;
resultado = a * b + c;

// Sin espacio antes de paréntesis en llamadas a función
funcion(parametro);
otra_funcion(param1, param2);

// Espacio después de palabras clave
if (condicion) {
  // código
}

while (condicion) {
  // código
}

for (i = 0; i < n; i++) {
  // código
}

// Sin espacios dentro de paréntesis
if (a == b) {  // Correcto
if ( a == b ) { }  // Incorrecto
```

#### Longitud de Línea

- Máximo **100 caracteres** por línea
- Divide líneas largas de forma lógica y legible
- Alinea parámetros en llamadas a funciones multilínea

```c
// Correcto - parámetros alineados
void funcion_con_muchos_parametros(uint32_t parametro1, uint32_t parametro2,
                                    uint32_t parametro3, uint32_t parametro4) {

  // código
}

// Correcto - continuación indentada
resultado = funcion_larga(primer_parametro,
                          segundo_parametro,
                          tercer_parametro);

// Correcto - operaciones complejas divididas
if (condicion_muy_larga_primera &&
    condicion_muy_larga_segunda &&
    condicion_muy_larga_tercera) {
  // código
}
```

#### Líneas en Blanco

```c
// Línea en blanco después de la llave de apertura de funciones
void funcion_ejemplo(void) {

  uint32_t variable = 0;
  // código...
}

// Líneas en blanco para separar secciones lógicas
void funcion_compleja(void) {

  // Inicialización
  uint32_t contador = 0;
  bool_t estado = FALSE;
  
  // Configuración de periféricos
  UART_Init(UART0, 115200);
  GPIO_SetDir(GPIO0, PIN_LED, GPIO_OUTPUT);
  
  // Bucle principal
  while (TRUE) {
    // código del bucle
  }
}
```

### Nomenclatura

#### Funciones

```c
// Formato: MODULO_Funcion()
void GPIO_SetDir(LPC_GPIO_TypeDef *gpio, uint32_t pin, uint32_t dir);
void UART_Init(LPC_UART_TypeDef *uart, uint32_t baudrate);
```

#### Variables

```c
// snake_case para variables locales
uint32_t contador_actual = 0;
float temperatura_ambiente = 25.0;

// snake_case con prefijo para variables globales
volatile bool_t g_flag_timer = FALSE;
uint16_t g_valor_adc = 0;
```

#### Constantes y Macros

```c
// MAYÚSCULAS para constantes
#define LED_PIN    18
#define BUFFER_SIZE 256

// Macros con paréntesis
#define MAX(a, b)  (((a) > (b)) ? (a) : (b))
```

#### Tipos

```c
// PascalCase con sufijo _t
typedef struct {
    uint8_t hora;
    uint8_t minuto;
} Hora_t;

typedef enum {
    COLOR_ROJO,
    COLOR_VERDE,
    COLOR_AZUL
} Color_t;
```

### Documentación

#### Documentación de Archivo

```c
/**
 * @file    nombre_archivo.c
 * @brief   Descripción breve del archivo.
 *
 * Descripción más detallada del propósito y contenido del archivo.
 *
 * @author  Nombre Apellido - email@dominio.com
 * @date    2025
 * @version 2.0
 *
 * @copyright GNU General Public License version 3 or later
 */
```

#### Documentación de Función

```c
/**
 * @brief   Descripción breve de la función.
 *
 * Descripción más detallada del comportamiento de la función,
 * casos especiales, y cualquier información relevante.
 *
 * @param   parametro1  Descripción del primer parámetro.
 * @param   parametro2  Descripción del segundo parámetro.
 * @return  Descripción del valor de retorno.
 *
 * @note    Notas importantes sobre el uso.
 * @warning Advertencias sobre casos peligrosos.
 *
 * @code
 * // Ejemplo de uso
 * resultado = funcion(10, 20);
 * @endcode
 */
```

### Comentarios de Código

```c
// Comentarios de una línea explican el "por qué", no el "qué"

// Calcular el tiempo transcurrido en milisegundos
tiempo_ms = (tick_final - tick_inicial) * TICK_TO_MS;

/* Comentarios de múltiples líneas
 * para explicaciones más largas
 * o bloques de código temporalmente deshabilitados
 */
```

### Buenas Prácticas

#### Funciones

```c
// Mantén las funciones cortas y enfocadas
// Idealmente, una función debería caber en una pantalla

// Bien
void actualizar_temperatura(void) {
    uint16_t adc = ADC_Read(CANAL_TEMPERATURA);
    float temp = convertir_adc_a_celsius(adc);
    mostrar_temperatura(temp);
}

// Evita funciones muy largas
// Mal
void hacer_todo(void) {
    // 500 líneas de código...
}
```

#### Variables

```c
// Inicializa variables en la declaración cuando sea posible
uint32_t contador = 0;
bool_t estado = FALSE;

// Usa tipos apropiados
uint8_t edad;        // 0-255 es suficiente
uint32_t direccion;  // Direcciones de memoria necesitan 32 bits
```

#### Manejo de Errores

```c
// Verifica parámetros de entrada
void funcion(uint32_t *ptr, uint32_t valor) {
    if (ptr == NULL) {
        return ERROR_PARAM_NULL;
    }
    
    if (valor > MAX_VALOR) {
        return ERROR_PARAM_RANGE;
    }
    
    // Código de la función
}
```

#### Magic Numbers

```c
// Mal
if (pin == 18) { }
delay_ms(100);

// Bien
#define LED1_PIN 18
#define DEBOUNCE_TIME_MS 100

if (pin == LED1_PIN) { }
delay_ms(DEBOUNCE_TIME_MS);
```

## Documentación

### Documentación en Código

- Usa comentarios Doxygen para todas las APIs públicas
- Explica algoritmos complejos
- Documenta casos especiales y limitaciones
- Incluye ejemplos de uso cuando sea útil

### Documentación Externa

Al modificar funcionalidad, actualiza:

- `README.md` - Si afecta la descripción general
- `docs/LIBRERIAS.md` - Si modificas o añades librerías
- `docs/EJEMPLOS.md` - Si añades o modificas ejemplos
- `docs/HARDWARE.md` - Si afecta especificaciones de hardware
- `docs/INSTALACION.md` - Si cambias el proceso de instalación

### Documentación Educativa

Este es un proyecto educativo, así que:

- Explica conceptos que los estudiantes puedan no conocer
- Proporciona referencias a material de aprendizaje
- Incluye diagramas cuando ayuden a la comprensión
- Añade ejemplos progresivos (de simple a complejo)

## Testing

### Pruebas Requeridas

Antes de enviar un PR, asegúrate de:

1. **Compilación exitosa**
   - Sin errores
   - Sin advertencias (o justificadas)

2. **Prueba en hardware real**
   - Verifica en la Developer's Kit
   - Prueba todos los casos de uso
   - Verifica casos límite

3. **No romper funcionalidad existente**
   - Prueba ejemplos relacionados
   - Verifica compatibilidad

### Reportar Resultados de Pruebas

```markdown
## Pruebas Realizadas

### Compilación
- [x] Compila sin errores
- [x] Compila sin advertencias

### Hardware
- [x] Probado en LPC4088 Developer's Kit
- [x] Funciona correctamente con...
- [x] Casos límite verificados

### Compatibilidad
- [x] Ejemplos existentes funcionan correctamente
- [x] No rompe APIs existentes
```

## Proceso de Revisión

### Qué Esperamos

Los revisores verificarán:

1. **Corrección** - ¿El código hace lo que dice?
2. **Calidad** - ¿Sigue los estándares?
3. **Claridad** - ¿Es comprensible?
4. **Documentación** - ¿Está bien documentado?
5. **Tests** - ¿Fue probado adecuadamente?
6. **Valor educativo** - ¿Ayuda a los estudiantes?

### Tiempo de Respuesta

- Reviews iniciales: 1-2 semanas típicamente
- Este es un proyecto académico voluntario
- La paciencia es apreciada

### Después de la Revisión

- Responde a los comentarios
- Haz los cambios solicitados
- Solicita re-revisión
- Sé receptivo al feedback

## Preguntas Frecuentes

### ¿Puedo contribuir si soy estudiante?

¡Absolutamente! De hecho, las contribuciones de estudiantes son especialmente valiosas porque:

- Sabes qué es confuso y necesita mejor explicación
- Puedes aportar perspectiva fresca
- Es una excelente forma de aprender

### ¿Necesito experiencia previa con Git?

No es necesario ser experto, pero deberías conocer:

- Cómo hacer fork de un repositorio
- Commits básicos
- Crear pull requests

Hay muchos tutoriales excelentes en línea.

### ¿Qué pasa si mi PR es rechazado?

- No te desanimes
- Pide feedback específico
- Aprende de los comentarios
- Intenta de nuevo con mejoras

### ¿Puedo trabajar en un issue sin asignación previa?

Sí, pero:

- Comenta en el issue que estás trabajando en él
- Para cambios grandes, discute el enfoque primero
- Revisa si alguien más ya está trabajando en ello

### ¿Cómo puedo empezar?

Busca issues etiquetados con:

- `good first issue` - Buenos para principiantes
- `help wanted` - Necesitan colaboradores
- `documentation` - Mejoras de documentación
- `bug` - Correcciones de errores

## Recursos Adicionales

### Documentación Técnica

- [LIBRERIAS.md](docs/LIBRERIAS.md) - Referencia de librerías
- [EJEMPLOS.md](docs/EJEMPLOS.md) - Guía de ejemplos
- [HARDWARE.md](docs/HARDWARE.md) - Especificaciones de hardware

### Herramientas

- [Keil µVision](https://www.keil.com/download/product/)
- [Git](https://git-scm.com/)
- [Doxygen](https://www.doxygen.nl/)

### Aprendizaje

- [LPC40xx User Manual](https://www.nxp.com/)
- [ARM Cortex-M4 Documentation](https://developer.arm.com/)
- [C Programming](https://www.learn-c.org/)

## Agradecimientos

¡Gracias por contribuir al proyecto LPC4088-Documentacion! Tu tiempo y esfuerzo ayudan a mejorar la educación en sistemas embebidos para todos los estudiantes.

### Contribuyentes

Este proyecto existe gracias a todas las personas que contribuyen. Una lista de contribuyentes está disponible en:

- [GitHub Contributors](https://github.com/ale87jan/LPC4088-Documentacion/graphs/contributors)

## Licencia

Al contribuir, aceptas que tus contribuciones sean licenciadas bajo la misma licencia que el proyecto:

- **Código:** GNU General Public License v3.0 o posterior
- **Documentación:** GNU Free Documentation License v1.3 o posterior

---

**¿Preguntas?** Contacta a través de:

- Email: [alejandro.lara@uca.es](mailto:alejandro.lara@uca.es)
- Issues de GitHub: [Crear un issue](https://github.com/ale87jan/LPC4088-Documentacion/issues)

---

<div align="center">

<!-- markdownlint-disable-next-line -->
**¡Feliz programación embebida! 🚀**

</div>
