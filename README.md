# Proyecto Grupo 67 - IIC2413💻💡

Repositorio del proyecto semestral de Ingeniería de Software.

Actualmente en: **Sprint 2**.

## Participantes

### Dev Team

- Andrés Infante
- Santiago De La Carrera
- Vicente San Martín

### Product Owner

- Shantal Fabri

## Fecha de entrega S2

Domingo 26 de mayo, 23:59.

## Ruta de la aplicación

La aplicación puede ser accedida en el siguiente enlace:

[Iniciativas Estudiantiles](https://iiee.onrender.com/)

La página de desarrollo se encuentra en el siguiente enlace:

[Dev Iniciativas Estudiantiles](https://dev67.onrender.com/)

## Supuestos y consideraciones

- En la capacidad de los eventos no se toman en cuenta los administradores, ya que, como ellos lo organizan, saben cuántos son y lo tendrán en cuenta para cualquier cálculo.
- Si el Administrador de la página quiere cerrar un evento, basta con ponerle capacidad 0.
- Al iniciar sesión se redirije directamente a la Página de Iniciativas, ya que, es la base de toda la página y por donde todos empiezan a  navegar.
- Si se intenta utilizar el chat de una iniciativa de manera local (ejecutando `rails server` o `rails s` en consola), es posible obtener un error. Esto se debe a que es necesario instalar el servidor de redis de manera local. Para esto, se debe ejecutar en consola:

  - `sudo apt install redis-server`
  - `redis-server`
  - `rails server` o `rails s`

Para evitar lo anterior, recomendamos fuertemente probar el chat en [Iniciativas Estudiantiles](https://iiee.onrender.com/).

## Credenciales para la corrección

| Username | Correo | Contraseña |
|----------|--------|------------|
| vjsm    | <vjsm@uc.cl>    | DCClave    |
| ainfantep   | <a.infante@uc.cl>    | DCContraseña    |
| sa.dlcb    | <sa.delacarrera@uc.cl>    | DCCifrado    |

## Testing

Para realizar el testing general de la aplicación, se debe ejecutar en consola el siguiente comando:

- `rails test`

Luego se podrá revisar el coverage entregado por SimpleCov abriendo el archivo *coverage/index.html* en el browser, siempre y cuando la línea 23 de `test/test_helper.rb` esté comentada, es decir, solamente se habilite un procesador como worker.

De lo contrario, al activar la opción de *parallelize* para ver la cobertura de los test para modelos, controladores y helpers, es posible obtener inconsistencia en la cobertura por la ejecución paralela de tests.
