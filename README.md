---
title: Laboratorio de Funcional
author: Antonella Loyola, Nicolás Cagliero, Mauricio Llugdar
---
La consigna del laboratorio está en https://tinyurl.com/funcional-2024-famaf

# 1. Tareas
Pueden usar esta checklist para indicar el avance.

## Verificación de que pueden hacer las cosas.
- [ ] Haskell instalado y testeos provistos funcionando. (En Install.md están las instrucciones para instalar.)

## 1.1. Lenguaje
- [ ] Módulo `Dibujo.hs` con el tipo `Dibujo` y combinadores. Puntos 1 a 3 de la consigna.
- [ ] Definición de funciones (esquemas) para la manipulación de dibujos.
- [ ] Módulo `Pred.hs`. Punto extra si definen predicados para transformaciones innecesarias (por ejemplo, espejar dos veces es la identidad).

## 1.2. Interpretación geométrica
- [ ] Módulo `Interp.hs`.

## 1.3. Expresión artística (Utilizar el lenguaje)
- [ ] El dibujo de `Dibujos/Feo.hs` se ve lindo.
- [ ] Módulo `Dibujos/Grilla.hs`.
- [ ] Módulo `Dibujos/Escher.hs`.
- [ ] Listado de dibujos en `Main.hs`.

## 1.4 Tests
- [ ] Tests para `Dibujo.hs`.
- [ ] Tests para `Pred.hs`.

# 2. Experiencia
Utilizamos la librería Gloss. La experiencia que tuvimos fue completa. Al principio muchas complicaciones para agarrarle la mano de nuevo a haskell sumado a aprender cosas nuevas de haskell y además lograr entender la abstracción con la que estabamos trabajando. Luego, a medida que avanzamos con el laboratorio, las cosas salían más faciles y ya podíamos ver resultados en concreto. Al terminar ya era más divertido jugar con las figuras y hasta agregar colores. Muy bueno :)

# 3. Preguntas


## 3.1  ¿Por qué están separadas las funcionalidades en los módulos indicados? Explicar detalladamente la responsabilidad de cada módulo.

-Que las funcionalidades esten separadas en los modulos, hace que sea mas legible y entendible ver de donde trabaja cada modulo, ademas es una manera de dividir un problema grande, en problemas mas chicos y poder ir testeando cada uno de estos modulos por separado. Facilita la organizacion y representacion del programa. 
Cada modulo tiene una representacion clara, por ejemplo el modulo Dibujo se encarga de la sintaxis del programa, mientras que Interp se encarga de la semantica/interpretacion del leguaje y de la implementacion de cada figura basica.

-Responsabilidabes de cada modulo:
Dibujo.hs: Se hace la declaracion de las figuras de nuestro lenguaje, donde definimos los constructores de Dibujo y funciones que       utilizamos con ellas.
Interps.hs: Interpretacion geometrica de las figuras. Se encarga de la semantica de nuestro lenguaje. Esto significa tomar un dibujo y devolver su interpretación, en este caso mediante el uso de la biblioteca de gráficos Gloss (Se interpreta como un grafico bi-dimensional usando vectores).
Pred.hs: Extender la sintaxis del lenguaje para poder trabajar con predicados sobre los dibujos.
Escher.hs: Implementar la semántica/interpretación de las figuras básicas usadas en el dibujo "Escher", definición de combinadores y generación del dibujo de Escher.
Main.hs: Solicita al usuario que ingrese el nombre de un dibujo y muestra el resultado de interpretar el dibujo ingresado (si es que existe). También permite solicitar una lista de dibujos y seleccionar uno de ellos para mostrarlo.


## 3.2  ¿Por qué las figuras básicas no están incluidas en la definición del lenguaje, y en vez de eso, es un parámetro del tipo?

-La razon por la que las figuras basicas no estan incluidas en la definicion del lenguaje, y en cambio se pasan como un parametro del tipo, es para permitir la flexibilidad y la extensibilidad del lenguaje. Si las figuras basicas fueran parte de la definicion del lenguaje, el lenguaje estaria limitado a un conjunto fijo de formas. Sin embargo, al permitir que las figuras basicas sean especificadas por el usuario, el lenguaje se vuelve mas general y puede adaptarse a diferentes necesidades. En conclusion, al usar parametros de tipo, lo que hacemos es definir un lenguaje que opera sobre "figuras basicas", donde dichas figuras son definidas por el usuario a traves del parametro de tipo. 


## 3.3 ¿Qué ventaja tiene utilizar una función de `fold` sobre hacer pattern-matching directo?

-Utilizar una función de fold puede tener ventajas en términos de modularidad, abstracción y claridad, dependiendo del contexto en el que se esté trabajando.
- Modularidad porque al utilizar fold, se pueden separar las operaciones de recorrer la estructura y aplicar una operación sobre cada elemento. Esto facilita la creación de módulos
- Abstraccion porque el uso de fold permite abstraer el proceso de recorrer una estructura de datos y realizar una operación en cada elemento, lo que hace que el código sea más general y reutilizable. En cambio, el pattern-matching directo está más enfocado en una operación específica sobre una estructura de datos particula
- Claridad porque en algunos casos, el uso de fold puede hacer que el código sea más claro y fácil de entender, ya que permite separar la lógica de recorrer la estructura de datos de la lógica de la operación sobre cada elemento, lo que puede hacer que el código sea más fácil de leer y mantener.


## 3.4 ¿Cuál es la diferencia entre los predicados definidos en Pred.hs y los tests?.

La diferencia entre los predicados definidos en Pred.hs y los definidos en los tests es que los predicados definidos en Pred.hs sirven para la definicion de funciones que van a usar esos predicados como una condición, que de cumplirse, la funcion ejecutará un efecto en el dibujo que pasemos como parámetro. En cambio, en los tests damos predicados específicos para poder testear que las funciones hechas en Pred.hs tengan el funcionamiento esperado (se cumpla o no el predicado).

# 4. Extras
Acá nos gustaría aclarar que estuvimos trabajando, en su gran mayoría, en un live share de visual studio code los 3 integrantes del grupo hablando por Discord. Por lo tanto se notará una diferencia con la cantidad de commits hechos por cada integrante pues siempre figuraba el nombre del dueño del live share. Pero garantizamos que los 3 integrantes entendemos y trbajamos por igual en este lab :)
