insert into medio_de_pago values(1,'Tarjeta de Credito');
insert into medio_de_pago values(2,'Tarjeta de Debito');
insert into medio_de_pago values(3,'Efectivo');
insert into medio_de_pago values(4,'Rapipago/Paypal');

insert into envio values(1,'OCA');
insert into envio values(2,'Correo Argentino');
insert into envio values(3,'Retiro en local');

insert into producto values(null,'Auriculares','Auriculares Gamer Logitech G Pro X Headset Pc 7.1');
insert into producto values(null,'Anteojos','Tienda Oficial - Anteojos De Sol Ray Ban Justin 4165 Clásico');
insert into producto values(null,'Reloj','Reloj Montreal Unisex Ml236 Tienda Oficial Envío Gratis');
insert into producto values(null,'Mouse','Mouse Gamer Genius Gx X-g600 1600dpi 6 Botones Iluminado');
insert into producto values(null,'Pava','Pava Eléctrica Corte Automatico Mate + Fc Mantener Caliente');
insert into producto values(null,'Remera','Remera adidas Vrtcl Grfx Hombre');
insert into producto values(null,'Zapatillas','Zapatilla Mujer Plataforma Star Lona (consultexmayor)');
insert into producto values(null,'Dron','Drone DJI Tello con cámara Full HD white');
insert into producto values(null,'Vidrio','Cristal Espejo Exterior Cargo 12/19 Ford Cargo 12/19');
insert into producto values(null,'Pañales','Pañales Huggies Active Sec P Y Recien Nacido X 40');
insert into producto values(null,'Bombita','Pack X10 Lamparas Led 14w Osram Luz Fria / Calida E27');

insert into categoria values(null,'Audio');
insert into categoria values(null,'Autopartes');
insert into categoria values(null,'Electrdomesticos');
insert into categoria values(null,'Ropa');
insert into categoria values(null,'Componentes electronicos');
insert into categoria values(null,'Accesorios');
insert into categoria values(null,'Hogar');
insert into categoria values(null,'Calzado');
insert into categoria values(null,'Perifericos');
insert into categoria values(null,'PC');
insert into categoria values(null,'minecraft');



insert into usuario values(null,'Iñaki','Etchegoyen','inakietchegoyen@gmail.com','elrey',00000001,'Plaza 123',1112346875,1430,'URQ',0,'','','');
insert into usuario values(null,'Tomas','Gimenez','tomiux@gmail.com','totogang',00000002,'Olazabal 456',1198753452,1431,'BEL',0,'','','');
insert into usuario values(null,'Franco','Mosca','moskk14@gmail.com','duking',00000003,'Congreso 789',1102365887,1432,'COL',0,'','','');
insert into usuario values(null,'Jona','Longo','jhon&long@gmail.com','g2mixxwel',00000004,'Beiro 321',1196541023,1433,'CGH',0,'','','');
insert into usuario values(null,'Tobias','Rodriguez','toubyr@gmail.com','chromeggl',00000005,'De los Incas 654',1135796248,1434,'PAL',0,'','','');
insert into usuario values(null,'Agustin','Barbux','barbux@gmail.com','mysqlwrk',00000006,'Monroe 987',1136574568,1435,'DVT',0,'','','');
insert into usuario values(null,'Martin','Arzani','mijac@gmail.com','contraseña',00000007,'Benito 741',1187641597,1436,'VDP',0,'','','');
insert into usuario values(null,'Gian','Montemarani','gianfru@gmail.com','roudri10',00000008,'Escobar 852',1186543130,1437,'AGR',0,'','','');
insert into usuario values(null,'Tomas','Lasalde','tomatolasa@gmail.com','barbux32',00000009,'Mendoza 963',1132101786,1438,'PUY',0,'','','');
insert into usuario values(null,'Martin','Barbieri','tinchoide@gmail.com','dstwig',00000010,'Triunvirato 159',1135240944,1439,'BOC',0,'','','');

insert into publicacion values(null, now(), "Activa", "Bronce", "Subasta", 1500, 64,'2020-7-15',5, null, 1);
insert into publicacion values(null, now(), "Activa", "Bronce", "Venta directa", 780, 100, null, 5, NULL,3);
insert into publicacion values(null, now(), "Activa", "Bronce", "Subasta", 1500, 64,'2020-7-10', 6, NULL,4);
insert into publicacion values(null, now(), "Activa", "Plata", "Subasta", 15000, 6,'2020-7-1', 1,NULL,7);
insert into publicacion values(null, now(), "Pausada", "Bronce", "Subasta", 120, 1,'2020-7-25', 2,NULL,1);
insert into publicacion values(null, now(), "Activa", "Bronce", "Subasta", 420, 64,'2020-7-30', 6,NULL,6);
insert into publicacion values(null, now(), "Activa", "Oro", "Venta Directa", 4500, 64, NULL, 9,null,5);
insert into publicacion values(null, now(), "Activa", "Bronce", "Subasta", 300, 1, '2020-7-20',10,NULL,10);
insert into publicacion values(null, now(), "Activa", "Bronce", "Subasta", 1500, 64,'2020-7-2', 5,NULL,4); 
insert into publicacion values(null, now(), "Pausada", "Bronce", "Venta directa", 5000, 10, null, 5, NULL,5); 

insert into pregunta_respueta values(null,'¿Tiene stock?','2020-09-15','Hola buenas tardes. Si, todavía tenemos.','2020-09-12',1);
insert into pregunta_respueta values(null,'¿Con qué colores cuenta?', '2019-01-01', 'Buenos días. Tenemos solo 3 colores (blanco, rojo y negro)', '2019-01-03', 2);
insert into pregunta_respueta values(null,'¿Se puede pagar en efectivo?', '2020-03-30', 'Buenas. No estamos contando con stock de este producto', '2020-04-02', 3);
insert into pregunta_respueta values(null,'¿Con qué accesorios cuenta?', '2019-05-19', 'Se lo armamos a medida', '2019-05-25', 4);
insert into pregunta_respueta values(null,'¿Se puede retirar en el local?', '2018-06-20', 'Si, entre las14 y las 18 hs', '2018-06-20', 5);
insert into pregunta_respueta values(null,'¿Hacen envíos a todo el país?', '2020-03-19', 'Solamente hacemos envios a CABA', '2020-03-25', 6); 
insert into pregunta_respueta values(null,'¿Qué tiempo de uso tiene?', '2019-05-24', '1 mes de uso', '2019-05-25', 7);
insert into pregunta_respueta values(null,'¿Qué talles tiene?', '2019-05-19', 'Contamos con talles del S al Xl', '2019-06-01', 8);
insert into pregunta_respueta values(null,'¿Cuáles son las formas de pago?', '2020-05-19', 'buenas tardes. Mercado pago y efectivo', '2020-05-25', 9);
insert into pregunta_respueta values(null,'¿Hacen envios a Quilmes?', '2018-05-20', 'Si, pero con un recargo en el precio', '2018-05-25', 10);

insert into publicacion_has_categoria values (1, 5);
insert into publicacion_has_categoria values (1, 9); 
insert into publicacion_has_categoria values (1, 10);
insert into publicacion_has_categoria values (2, 4);
insert into publicacion_has_categoria values (2, 6); 
insert into publicacion_has_categoria values (3, 5); 
insert into publicacion_has_categoria values (3, 9); 
insert into publicacion_has_categoria values (3, 10); 
insert into publicacion_has_categoria values (4, 4);
insert into publicacion_has_categoria values (4, 8); 
insert into publicacion_has_categoria values (5, 1); 
insert into publicacion_has_categoria values (5, 5); 
insert into publicacion_has_categoria values (5, 9); 
insert into publicacion_has_categoria values (5, 10); 
insert into publicacion_has_categoria values (6, 4);
insert into publicacion_has_categoria values (7, 3); 
insert into publicacion_has_categoria values (8, 4); 
insert into publicacion_has_categoria values (9, 5); 
insert into publicacion_has_categoria values (9, 9); 
insert into publicacion_has_categoria values (9, 10); 

insert into publicacion_has_pregunta_respueta values(1,1);
insert into publicacion_has_pregunta_respueta values(2,2);
insert into publicacion_has_pregunta_respueta values(3,3);
insert into publicacion_has_pregunta_respueta values(4,4);
insert into publicacion_has_pregunta_respueta values(5,5);
insert into publicacion_has_pregunta_respueta values(6,6);
insert into publicacion_has_pregunta_respueta values(7,7);
insert into publicacion_has_pregunta_respueta values(8,8);
insert into publicacion_has_pregunta_respueta values(9,9);
insert into publicacion_has_pregunta_respueta values(10,10);
insert into publicacion_has_pregunta_respueta values(1,10);
insert into publicacion_has_pregunta_respueta values(2,9);
insert into publicacion_has_pregunta_respueta values(3,8);
insert into publicacion_has_pregunta_respueta values(4,7);
insert into publicacion_has_pregunta_respueta values(5,6);
insert into publicacion_has_pregunta_respueta values(6,5);

