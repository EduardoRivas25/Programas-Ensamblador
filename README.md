# ⚙️ Programas en Lenguaje Ensamblador

![Assembly](https://img.shields.io/badge/Language-Assembly-red)
![Architecture](https://img.shields.io/badge/Architecture-x86-blue)
![Status](https://img.shields.io/badge/Status-Academic%20Project-green)
![License](https://img.shields.io/badge/License-Educational-lightgrey)

Repositorio que contiene **ejercicios, prácticas y ejemplos desarrollados en lenguaje ensamblador**, realizados durante el curso de **Lenguajes de Interfaz** en la carrera de **Ingeniería en Sistemas Computacionales**.

El objetivo es comprender el funcionamiento de la computadora **a bajo nivel**, trabajando directamente con **registros, memoria y operaciones del procesador**.

---

# 📚 Tabla de Contenidos

* [📖 Descripción](#-descripción)
* [🧠 Objetivos](#-objetivos)
* [📂 Estructura del Proyecto](#-estructura-del-proyecto)
* [🛠 Tecnologías Utilizadas](#-tecnologías-utilizadas)
* [🚀 Cómo ejecutar los programas](#-cómo-ejecutar-los-programas)
* [📘 Ejemplos de ejercicios](#-ejemplos-de-ejercicios)
* [👨‍💻 Autor](#-autor)
* [📄 Licencia](#-licencia)

---

# 📖 Descripción

El **lenguaje ensamblador (Assembly)** es un lenguaje de programación de bajo nivel que permite interactuar directamente con la arquitectura del procesador.

A diferencia de los lenguajes de alto nivel, el ensamblador trabaja con **instrucciones específicas del CPU**, lo que permite comprender con mayor profundidad:

* El funcionamiento interno del procesador
* La manipulación de registros
* El manejo de memoria
* Las operaciones aritméticas a nivel de máquina
* La interacción directa con el sistema

Este repositorio reúne distintos **programas de práctica** diseñados para aprender estos conceptos.

---

# 🧠 Objetivos

Este proyecto académico tiene como propósito:

✔ Comprender el funcionamiento interno de una computadora
✔ Aprender el manejo de **registros del procesador**
✔ Implementar **operaciones aritméticas en bajo nivel**
✔ Entender cómo se ejecutan las instrucciones del CPU
✔ Desarrollar lógica de programación utilizando ensamblador

---

# 📂 Estructura del Proyecto

```bash
Programas-Ensamblador
│
├── programa1.asm
├── programa2.asm
├── programa3.asm
│
└── README.md
```

Cada archivo `.asm` corresponde a un **programa o ejercicio independiente**.

Los archivos incluyen **comentarios dentro del código** para facilitar su comprensión.

---

# 🛠 Tecnologías Utilizadas

| Tecnología         | Descripción                            |
| ------------------ | -------------------------------------- |
| Assembly           | Lenguaje de programación de bajo nivel |
| x86                | Arquitectura del procesador            |
| MASM / TASM / NASM | Ensambladores utilizados               |
| Windows            | Sistema operativo de ejecución         |

---

# 🚀 Cómo ejecutar los programas

Para ejecutar los programas de este repositorio se necesita un **ensamblador compatible**.

## 1️⃣ Instalar NASM

Descargar desde:

https://www.nasm.us/

---

## 2️⃣ Compilar el programa

```bash
nasm -f win32 programa.asm
```

---

## 3️⃣ Enlazar el archivo objeto

```bash
gcc programa.obj -o programa.exe
```

---

## 4️⃣ Ejecutar el programa

```bash
programa.exe
```

---

# 📘 Ejemplos de ejercicios

Algunos de los ejercicios incluidos en este repositorio pueden incluir:

🔹 Programas de **entrada y salida**
🔹 **Operaciones aritméticas** básicas
🔹 Comparación de números
🔹 Manejo de **registros del CPU**
🔹 Uso de **interrupciones**
🔹 Ejercicios de lógica en ensamblador

---

# 👨‍💻 Autor

**Eduardo Rivas**
📚 Curso: *Lenguajes de Interfaz*

---

# 📄 Licencia

Este repositorio se publica únicamente con fines **educativos y académicos**.

---

⭐ Si este repositorio te resulta útil para aprender ensamblador, ¡no olvides darle **Star**!
