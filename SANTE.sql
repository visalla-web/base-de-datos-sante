create database SANTE;
use SANTE;

create table medicamentos(
idmedicamentos int auto_increment primary key, 
nombreproduc varchar(50) not null,
codigo varchar(50) unique not null,
laboratorio varchar(100) not null,
descripcion varchar(255)
);

create table proveedor (
idproveedor int auto_increment primary key,
nombre varchar(50) not null,
contacto varchar(50) not null,
telefono varchar(50) not null,
gmail varchar(50) not null,
direccion varchar(50) not null
);

create table compraprovedor (
idcompra int auto_increment primary key,
fechacompra date not null,
nrofactura varchar(50) unique not null,
totalcompra decimal(10,2) not null,
idproveedor int not null,
foreign key (idproveedor) references Proveedor(idproveedor)
);

create table detalledecompra (
iddetallecompra int auto_increment primary key,
lote varchar(50),
fechavencimiento date,
cantidad int not null,
preciocompra decimal(10,2) not null,
precioventa decimal(10,2) not null,
idcompra int not null,
foreign key (idcompra) references compraproveedor(idcompra),
idmedicamento int not null,
foreign key (idmedicamento) references medicamentos(idmedicamento)
);

create table inventario (
idinventario int auto_increment primary key,
stockactual int not null,
stockminimo int default 5,
idmedicamentos int not null,
foreign key (idmedicamentos) references medicamentos(idmedicamentos),
iddetallecompra int not null,
foreign key (iddetallecompra) references detallecompra(iddetallecompra)
);

create table cliente (
idcliente int auto_increment primary key,
nombre varchar(100) not null,
ci_nit varchar(20),
telefono varchar(20),
direccion varchar(150)
);

create table venta (
idventa int auto_increment primary key,
fechaventa datetime not null,
formapago enum('efectivo','tarjeta','qr','credito') not null,
totalventa decimal(10,2) not null,
idcaja int default 1,  -- multicaja
idcliente int,
foreign key (idcliente) references cliente(idcliente)
);

create table detalleventa (
iddetalleventa int auto_increment primary key,
cantidad int not null,
preciounitario decimal(10,2) not null,
descuento decimal(10,2) default 0,
subtotal decimal(10,2) not null,
idventa int not null,
foreign key (idventa) references venta(idventa),
idmedicamentos int not null,
foreign key (idmedicamentos) references medicamentos(idmedicamentos)
);

create table devolucionventa (
iddevolucion int auto_increment primary key,
cantidad int not null,
motivo varchar (100),
fechadevolucion datetime default current_timestamp,
iddetalleventa int not null,
foreign key (iddetalleventa) references detalleventa(iddetalleventa)
);

create table ajusteinventario (
idajuste int auto_increment primary key,
cantidad int not null,
tipo enum('entrada','salida') not null,
motivo varchar(255)not null,
fecha datetime default current_timestamp,
idmedicamento int not null,
foreign key (idmedicamento) references medicamentos(idmedicamento),
idusuario int not null,
foreign key (idusuario) references usuario(idusuario)
);

create table usuario (
idusuario int auto_increment primary key,
nombreusuario varchar(50) unique not null,
contrasena varchar(25) not null,
rol enum('administrador','farmaceutico','cajero') not null
);

create table auditoria (
idauditoria int auto_increment primary key,
accion varchar(255) not null,
fechahora datetime default current_timestamp,
idusuario int not null,
foreign key (idusuario) references usuario(idusuario)
);