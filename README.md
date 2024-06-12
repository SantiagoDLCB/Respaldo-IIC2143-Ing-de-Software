# Proyecto Grupo 67 - IIC2413💻💡

Repositorio del proyecto semestral de Ingeniería de Software.

Actualmente en: **Sprint 3**.

## Participantes

### Dev Team

- Andrés Infante
- Santiago De La Carrera
- Vicente San Martín

### Product Owner

- Shantal Fabri

## Fecha de entrega y presentación

Entrega Sprint 3: Viernes 14 de junio, 23:59.

Presentación Final: Lunes 17 de junio.

## Ruta de la aplicación

La aplicación puede ser accedida en el siguiente enlace: [Iniciativas Estudiantiles](https://iiee.onrender.com/)

La página de desarrollo se encuentra en el siguiente enlace: [Dev Iniciativas Estudiantiles](https://dev67.onrender.com/)

## Supuestos y consideraciones

- El administrador de la página, cuyas credenciales se encuentran en la siguiente sección, tiene todos las cualidades de un usuario normal pero también tiene en la barra superior un botón 'Administrar' que le permite administrar toda la página.
- En la capacidad de los eventos no se toman en cuenta los administradores, ya que, como ellos lo organizan, saben cuántos son y lo tendrán en cuenta para cualquier cálculo.
- Si el administrador de la página quiere cerrar un evento, basta con ponerle capacidad 0.
- Al iniciar sesión se redirije directamente a la página de iniciativas, ya que es la base de toda la página y por donde es recomendable iniciar la  navegación.
- Si se intenta utilizar el chat de una iniciativa de manera local (ejecutando `rails server` o `rails s` en consola), es posible obtener un error. Esto se debe a que es necesario instalar el servidor de redis de manera local. Para esto, se debe ejecutar en consola:

  - `sudo apt install redis-server`
  - `redis-server`
  - `rails server` o `rails s`

Para evitar lo anterior, recomendamos fuertemente evitar probar el chat localmente, y en lugar de eso hacerlo en la aplicación ([Rutas](#ruta-de-la-aplicación)).

## Credenciales para la corrección

Algunas credenciales para facilitar la corrección en [Iniciativas Estudiantiles](https://iiee.onrender.com/) son:

| Username | Correo | Contraseña |
|----------|--------|------------|
| Dios    | <jmun@uc.cl>    | DCChavales    |
| vjsm    | <vjsm@uc.cl>    | DCClave    |
| ainfantep   | <a.infante@uc.cl>    | DCContraseña    |
| sa.dlcb    | <sa.delacarrera@uc.cl>    | DCCifrado    |

**El usuario Dios corresponde al administrador general de la página.*

## Testing

Para realizar el testing general de la aplicación, se debe ejecutar en consola el siguiente comando:

- `rails test`

Luego se podrá revisar el coverage entregado por SimpleCov abriendo el archivo ***coverage/index.html*** en el browser, siempre y cuando la línea 23 de `test/test_helper.rb` esté comentada, es decir, solamente se habilite un procesador como worker.

De lo contrario, al activar la opción de *parallelize* para ejecutar los tests, al revisar la cobertura de los test para modelos, controladores y helpers, es posible obtener inconsistencia en los porcentajes de cobertura por la ejecución paralela de tests.

## Documentación y funcionamiento

### Documentación

Para acceder a la documentación oficial de la aplicación, se debe abrir el archivo ***doc/index.html*** en el browser.

### Funcionamiento general

A grandes rasgos, la idea principal de la página es ser una central de iniciativas estudiantiles de la UC. Cada estudiante puede tener una cuenta personal para interactuar con las iniciativas existentes o crear una propia. Además, cada iniciativas tiene la capacidad de organizar eventos con cierta temática. A continuación se desglosan las principales funcionalidades de la aplicación por tópicos:

- **Página de inicio**: al entrar a la página, por defecto se llega a una landing page que contiene la información general de la aplicación, las iniciativas más recientes y una galería de fotos. Esta presenta las opciones tanto para iniciar sesión como para registrarse.
- **Cuentas y sesiones**: existe la posibilidad de usar un usuario ya creado o crear uno nuevo. Desde la barra de navegación, al seleccionar el botón de `Registrarse`, se le permite al usuario ingresar nuevas credenciales para hacer un registro en la página: username, nombre, apellido, correo, contraseña y opcionalmente un avatar. Por otra parte, al seleccionar el botón `Iniciar Sesión`, se da la posibilidad de utilizar una cuenta ya creada por el usuario, o bien utilizar alguna credencial presente en la sección de [Credenciales](#credenciales-para-la-corrección), debiendo ingresar el correo y contraseña. Por último, una vez que hay una sesión iniciada, se redirige a la página principal que muestra todas las iniciativas, donde al presionar el botón `Cerrar Sesión`, la cuenta es cerrada de manera automática y se redirige al inicio de sesión.
- **Perfil**: si hay una sesión iniciada, al apretar sobre `Ver Perfil` en la barra de navegación, se redirige a una página que contiene toda la información sobre la cuenta del usuario y su información de perfil, como su correo, nombre, apellido, username, foto de perfil (si no tiene, se muestra una por defecto), así como también las iniciativas y eventos en los que participa y su rol dentro de ellos, estado de sus solicitudes, y información sobre la cuenta misma como la fecha de creación o la última fecha de modificación. Además, se presenta la alternativa de usar la API de Unsplash para buscar fotos que puedan ser usadas como foto de perfil por el usuario. Por último, el usuario tiene la opción de modificar cualquier información de su perfil, debiendo ingresar la contraseña actual para confirmar los cambios.
- **Iniciativas**: este es el tópico principal de la aplicación. Una iniciativa puede ser creada por un usuario desde la página principal que muestra la lista de todas las iniciativas que existe, a la cual se accede desde `Iniciativas` en la barra de navegación. Al presionar el botón de `Crear Iniciativa`, se piden los datos para crear una nueva iniciativa: nombre, tema, descripción y opcionalmente una imagen. Cuando se confirma la creación el usuario pasa a ser el administrador de la iniciativa, y tiene la facultad de crear eventos, gestionar solicitudes de unión, administrar los roles (hacer administrador o degradar a miembro), editar la información de la iniciativa, buscar fotos con la API de Unsplash para utilizar en la iniciativa, y por supuesto eliminar la iniciativa. Otro usuario que desea ser parte de dicha iniciativa, puede visitarla desde la página que las tiene a todas y enviar una solicitud. Cuando este es aceptado por algún administrador, puede abandonar la iniciativa, reportarla por algún motivo, como también enviar y recibir mensajes a través del chat. Además, puede revisar los eventos creados por la iniciativa y decidir si unirse para formar parte de estas actividades temporales, los cuales serán explicados con más detalle a continuación.
- **Eventos**: los eventos son una manera de llevar a cabo actividades por parte de las iniciativas. Cuando un administrador de una iniciativa crea un evento en nombre de esta, estos quedan 'enlazados' (es decir, el evento queda perteneciendo a la iniciativa donde fue creado) y el evento puede ser visitado desde la página de dicha iniciativa. Todos los administradores de la iniciativa son también de sus eventos, y pueden crear anuncios para transmitir información a los participanes, administrar el rol de los participantes, editar la información, eliminar el evento, y cerrarlo una vez haya finalizado. Por otra parte, un evento es público, por lo que cualquier usuario puede unirse si existe espacio suficiente, y todos los eventos de la aplicación pueden ser explorados desde la página de eventos a la cual se accede con el botón `Eventos` desde la barra de navegación. Al unirse a un evento, existe la posibilidad de leer los anuncios enviados en este, y crear una reseña con una puntuación y mensaje para dejar una opinión acerca de la actividad. Finalmente, cuando un evento se da por terminado y es cerrado por los administradores, se agrega a la sección de 'Eventos Finalizados' en la página de la iniciativa. Al visitarlo, es posible ver toda la información, pero no se puede interactúar de ninguna manera con este (es decir, editar su información, participantes, dejar una reseña, etc.).
- **Funciones de administrador**: cuando el administrador general de la página inicia sesión, cuyas credenciales se encuentran en la sección de [Credenciales](#credenciales-para-la-corrección), se le presenta en la barra de navegación un botón extra llamado `Administrar`. Al seleccionar esta opción, el administrador general tiene una interfaz de panel de control para gestionar (ver, crear, editar y eliminar) todos los modelos de la aplicación: usuarios, roles, eventos, iniciativas, mensajes, anuncios, reportes, reseñas y solicitudes. Por ende, el administrador general tiene la capacidad total de eliminar usuarios, eliminar iniciativas, modificar eventos, entre otros, pero también puede participar como un usuario normal en la aplicación mediante la interfaz que todo usuario tiene.
