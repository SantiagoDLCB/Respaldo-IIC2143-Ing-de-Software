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

## Supuestos utilizados

- En la capacidad de los eventos no se toman en cuenta los administradores, ya que, como ellos lo organizan, saben cuántos son y lo tendrán en cuenta para cualquier cálculo.
- Si el Administrador de la página quiere cerrar un evento, basta con ponerle capacidad 0.
- Al iniciar sesión se redirije directamente a la Página de Iniciativas, ya que, es la base de toda la página y por donde todos empiezan a  navegar.

## Credenciales para la corrección

| Username | Correo | Contraseña |
|----------|--------|------------|
| vjsm    | <vjsm@uc.cl>    | DCClave    |
| ainfantep   | <a.infante@uc.cl>    | DCContraseña    |
| sa.dlcb    | <sa.delacarrera@uc.cl>    | DCCifrado    |

## Testing

Para realizar el testing general de la aplicación, se debe ejecutar en consola el siguiente comando:

- `rails test`

Sin embargo, debido a algunos errores que puede presentar la gema SimpleCov al momento de mostrar la cobertura de los test para modelos, controladores y helpers, recomendamos ejecutar los tests por separado. Es decir:

- `rails test test/models/`
- `rails test test/controllers/`
- `rails test test/helpers/`

Luego, revisar el coverage abriendo el archivo *coverage/index.html* en el browser.
