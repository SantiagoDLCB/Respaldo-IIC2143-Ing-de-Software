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

## Fecha de entrega S3

Viernes 14 de junio, 23:59.

## Fecha de presentación final

Lunes 17 de junio.

## Ruta de la aplicación

La aplicación puede ser accedida en el siguiente enlace:

[Iniciativas Estudiantiles](https://iiee.onrender.com/)

La página de desarrollo se encuentra en el siguiente enlace:

[Dev Iniciativas Estudiantiles](https://dev67.onrender.com/)

## Supuestos y consideraciones

- El administrador de la página, cuyas credenciales se encuentran en la siguiente sección, tiene todos las cualidades de un usuario normal pero también tiene en la barra superior un botón 'Administrar' que le permite administrar toda la página.
- En la capacidad de los eventos no se toman en cuenta los administradores, ya que, como ellos lo organizan, saben cuántos son y lo tendrán en cuenta para cualquier cálculo.
- Si el administrador de la página quiere cerrar un evento, basta con ponerle capacidad 0.
- Al iniciar sesión se redirije directamente a la página de iniciativas, ya que es la base de toda la página y por donde es recomendable iniciar la  navegación.
- Si se intenta utilizar el chat de una iniciativa de manera local (ejecutando `rails server` o `rails s` en consola), es posible obtener un error. Esto se debe a que es necesario instalar el servidor de redis de manera local. Para esto, se debe ejecutar en consola:

  - `sudo apt install redis-server`
  - `redis-server`
  - `rails server` o `rails s`

Para evitar lo anterior, recomendamos fuertemente evitar probar el chat localmente, y en lugar de eso hacerlo en [Iniciativas Estudiantiles](https://iiee.onrender.com/).

- Las fotos en active storage se “pierden” cuando render baja la app después de un periodo sin actividad, por lo que al volver a ingresar, no se logran renderizar. Esto se debe a que en Render para tener acceso a un disco permanente (que no haga reset de archivos entre deploys y tiempos largos) se debe que pagar un upgrade.

## Credenciales para la corrección

| Username | Correo | Contraseña |
|----------|--------|------------|
| Dios    | <jmun@uc.cl>    | DCChavales    |
| vjsm    | <vjsm@uc.cl>    | DCClave    |
| ainfantep   | <a.infante@uc.cl>    | DCContraseña    |
| sa.dlcb    | <sa.delacarrera@uc.cl>    | DCCifrado    |

*El usuario Dios corresponde al administrador general de la página.

## Testing

Para realizar el testing general de la aplicación, se debe ejecutar en consola el siguiente comando:

- `rails test`

Luego se podrá revisar el coverage entregado por SimpleCov abriendo el archivo *coverage/index.html* en el browser, siempre y cuando la línea 23 de `test/test_helper.rb` esté comentada, es decir, solamente se habilite un procesador como worker.

De lo contrario, al activar la opción de *parallelize* para ejecutar los tests, al revisar la cobertura de los test para modelos, controladores y helpers, es posible obtener inconsistencia en los porcentajes de cobertura por la ejecución paralela de tests.

## Documentación

Para acceder a la documentación oficial de la aplicación, se debe abrir el archivo *doc/index.html* en el browser.
