# Aplicación Gigantes

Aplicación móvil desarrollada en Flutter para la exposición **"Gigantes: Grandes dinosaurios de la Sierra de la Demanda de Burgos"**, organizada por la Universidad de Burgos y La Estación de la Ciencia y la Tecnología en colaboración con el Museo de Dinosaurios de Salas de los Infantes.

La aplicación tiene como objetivo complementar la visita a la exposición mediante contenidos interactivos, recursos multimedia y actividades educativas que permiten ampliar la información sobre los dinosaurios de la Sierra de la Demanda y los talleres asociados a la muestra.

## Características

### Sistema multilenguaje

La aplicación permite seleccionar el idioma desde la pantalla inicial.

Idiomas disponibles:

* Español
* Inglés
* Francés

Todo el contenido de la aplicación se adapta automáticamente al idioma seleccionado.

### Escaneo de códigos QR

Los visitantes pueden escanear códigos QR distribuidos por la exposición para acceder de forma rápida a información específica relacionada con las distintas zonas expositivas.

### Catálogo de dinosaurios

La aplicación incluye un listado de dinosaurios presentes en la exposición donde el usuario puede consultar:

* Nombre del dinosaurio.
* Descripción.
* Información paleontológica.
* Imágenes ilustrativas.
* Audio explicativo.

Cada dinosaurio puede consultarse de manera individual sin necesidad de recorrer toda la exposición.

### Sistema de audio accesible

La información puede reproducirse mediante síntesis de voz (Text-To-Speech), permitiendo que los contenidos estén disponibles tanto en formato visual como auditivo.

Características:

* Reproducción y pausa de audio.
* Lectura en varios idiomas.
* Acceso individual a cada contenido.

### Catálogo de talleres

La aplicación incorpora un listado completo de los talleres educativos asociados a la exposición.

Cada taller incluye:

* Título.
* Descripción.
* Horario.
* Imagen representativa.

Los datos se obtienen desde Firebase Firestore, permitiendo su actualización sin necesidad de modificar la aplicación.

### Minijuegos educativos

La aplicación incluye varios minijuegos inspirados en el mundo de los dinosaurios y diseñados para reforzar el aprendizaje mediante la gamificación.

Actualmente se encuentran disponibles:

* Memory Jurásico.
* Puzzle de Dinosaurios.
* Excavación Paleontológica.
* Alas Jurásicas.
* Dino Lucha.
* Hambre Jurásica.

### Funcionamiento híbrido

La aplicación combina contenidos locales con contenidos almacenados en Firebase:

#### Recursos locales

* Imágenes.
* Audios.
* Elementos gráficos.
* Recursos de minijuegos.

#### Recursos remotos

* Información de talleres.
* Actualizaciones de contenido.
* Datos configurables desde Firestore.

## Tecnologías utilizadas

* Flutter
* Dart
* Firebase Firestore
* Firebase Core
* Mobile Scanner
* Flutter TTS
* Audioplayers
* Photo View
* Google Fonts

## Arquitectura

La aplicación ha sido desarrollada siguiendo una estructura modular basada en pantallas, modelos, servicios y recursos multimedia.

Principales módulos:

* Sistema de idiomas.
* Gestión de dinosaurios.
* Gestión de talleres.
* Escaneo QR.
* Sistema de audio.
* Minijuegos.
* Navegación entre pantallas.

Esta organización facilita el mantenimiento y la incorporación de nuevas funcionalidades.

## Adaptación a futuras exposiciones

La aplicación ha sido diseñada para poder reutilizarse en otros proyectos expositivos similares.

Para adaptarla será necesario:

* Sustituir imágenes y recursos gráficos.
* Actualizar los contenidos almacenados en Firebase.
* Incorporar nuevos audios.
* Modificar los textos informativos.
* Generar nuevos códigos QR si fuese necesario.

La estructura principal de la aplicación puede mantenerse sin cambios significativos.

## Accesibilidad

La aplicación incorpora medidas orientadas a mejorar la accesibilidad:

* Interfaz visual sencilla e intuitiva.
* Botones de gran tamaño.
* Contenidos disponibles en varios idiomas.
* Información en formato visual y auditivo.
* Navegación simplificada.
* Compatibilidad con dispositivos móviles Android e iOS.

## Relación con la exposición

La aplicación forma parte del proyecto expositivo:

**Gigantes: Grandes dinosaurios de la Sierra de la Demanda de Burgos**

La exposición presenta la evolución de los grandes saurópodos que habitaron la actual Sierra de la Demanda durante el Jurásico y el Cretácico, poniendo especial atención en especies como:

* Demandasaurus darwini.
* Europatitan eastwoodi.

Además de la visita presencial, la aplicación permite ampliar la experiencia educativa mediante recursos digitales, contenidos interactivos y actividades complementarias.

## Autores

Proyecto desarrollado por estudiantes de 1º DAM para la exposición:

* Verónica Bernabé Hortigüela
* Rodrigo Cueto del Torno
* Ángela Cereceda Pampliega

### Entidades colaboradoras

* Universidad de Burgos
* La Estación de la Ciencia y la Tecnología
* Museo de Dinosaurios de Salas de los Infantes

### Proyecto expositivo

Gigantes: Grandes dinosaurios de la Sierra de la Demanda de Burgos.
