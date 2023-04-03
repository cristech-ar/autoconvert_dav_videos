# Sistema de Conversión de videos de cámaras de seguridad marca Dahua y sincronización con AWS (Amazon Web Services)


REQUISITOS PREVIOS

- Sistema Operativo Linux (Las pruebas se realizaron sobre Ubuntu Server 20.04) con 500 GB de almacenamiento

# PROCESO DE INSTALACIÓN Y CONFIGURACIÓN DEL SERVIDOR

- Instalación de librería ffmpeg (Es el core del reproductor multimedia VLC) con la que se realiza la conversión. 
  Para instalarla se debe correr los siguientes comandos : 
  sudo apt update
  sudo apt install ffmpeg 

- Conexión con la red donde están las cámaras , para ello se utilizó la conexión VPN PPTP proporcionada por Quick.
  Para ello, se debe instalar el paquete net-tools y configurar la conexión PPTP  :
  
  sudo apt install net-tools
  
Para instalar el cliente vamos a ir a la carpeta del PTP para crear la respectiva configuración

cd /etc/ppp/peers
Estando allí, creamos el archivo

touch PPTP
y lo abrimos para editarlo

nano /etc/ppp/peers/PPTP
En el archivo copiaremos lo siguiente:

pty "pptp IP_DEL_SERVIDOR --nolaunchpppd --debug"
name Username
password CLAVE
remotename PPTP
require-mschap-v2
refuse-eap
refuse-pap
refuse-chap
refuse-mschap
noauth
debug
persist
maxfail 0
defaultroute
replacedefaultroute
usepeerdns

Remplazamos los respectivos campos, como la IP, el User y el Password.

Grabamos el archivo con Ctrl+X seguido de Y y le damos permisos al archivo:

chmod 600 /etc/ppp/peers/PPTP

A este punto ya estamos listos para tener conexion y para ello vamos a escribir:

pon PPTP

Revisamos si cargo y conecto con el comando : 

ifconfig

UN PUNTO IMPORTANTE ES QUE, SE DEBERÁ SOLICITAR UNA IP FIJA DENTRO DE LA VPN.

# INSTALACIÓN Y CONFIGURACIÓN DE SERVIDOR FTP

Para este caso se utilizó el paquete vsftpd que crea un servidor FTP, se instala con el siguiente comando :

sudo apt install vsftpd

Luego, se debe configurar mediante el siguiente archivo

/etc/vsftpd.conf

El parámetro más importante que debemos descomentar en archivo es el siguiente:

    write_enable=YES –> Esta directiva nos permite poder escribir (copiar archivos y carpetas) al servidor FTP.
   


# CONFIGURACIÓN DEL CRONTAB 


Para configurar el Crontab se debe correr el comando :

crontab -e

Si es la primera vez que se abre, se deberá elegir un editor de texto que puede ser Vi- Vim o nano. 
Para este procedimiento cualquiera es válido.

Una vez dentro del archivo Crontab se deben agregar las siguientes líneas (reemplazando la ruta donde se clonó el repositorio):

*/60 * * * * /[ruta -al repositorio]/converter.sh

0 3 * * * /[ruta al repositorio]/limpiador.sh

*  *  *  *  *  /[ruta al repositorio]/fecha.sh

#INSTALACION y  CONFIGURACIÓN AWS
Se debe instalar la CLI de Amazon Web Services con el siguiente comando :

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

se debe descomprimir el archivo descargado:

unzip awscliv2.zip

y luego instalar con el comando :

sudo ./aws/install

confirmar si se ha instalado con el comando :

aws --version

Para configurar el comando:

aws configure

El cual responde con un formulario en la consola, donde se debe cargar el acces key y el secret de AWS .

#CONFIGURACIÓN EN GRABADOR NVR / DVR
- Ingresar a la interfaz de configuración del grabador de cámaras
- Configurar el FTP con los datos del servidor que se acaba de montar
- IP , user y password.
- Configurar la grabación todos los días, todas las cámaras.
- El tamaño máximo de archivo se puede setear para comenzar en 50 mb, se puede ir variando en función de la performance que se quiere lograr.


# CLONAR REPOSITORIO CON SCRIPTS

Luego de la instalación Y configuración  de los requisitos previos, se deben copiar los scripts. 
Para ello, se puede clonar el repositorio de Github con el siguiente comando :

git clone https://github.com/crdev-ar/autoconvert_dav_videos

Por último , se debe chequear con el comando top los procesos que están corriendo en el sistema.
Los procesos ffmpeg y vsftpd deberán estar corriendo 24/7 




