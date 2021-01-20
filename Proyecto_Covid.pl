:- use_module(library(pce)).
:- use_module(library(pce_util)).
:- pce_image_directory('./image').

resource(bienvenida, image, image('welcome.jpg')).
resource(recomendaciones, image, image('recomendaciones.jpg')).
resource(covid1, image, image('covid1.jpg')).
resource(covid2, image, image('covid2.jpg')).
resource(dengue, image, image('dengue.jpg')).
resource(influenza, image, image('influenza.jpg')).
resource(neumonia, image, image('neumonia.jpg')).
resource(resfriadoc, image, image('resfriadoc.jpg')).
resource(desconocida, image, image('desconocida.jpg')).


nueva_imagen(Ventana, Imagen, Posicion) :-
new(Figura, figure),
new(Bitmap, bitmap(resource(Imagen),@on)),
send(Bitmap, name, 1),
send(Figura, display, Bitmap),
send(Figura, status, 1),
send(Ventana, display, Figura, Posicion).


iniciar:-
        new(Main, dialog('Bienvenido')),
        new(Btnform,button('INICIAR',and(message(@prolog,factores),message(Main,destroy)))),
	nueva_imagen(Main,bienvenida,point(0,0)),
        send(Main,display,Btnform,point(350,490)),
        send(Main,open_centered).

factores:- new(Ventana, dialog('')),
           new(Factores, menu('Factores de Riesgo', cycle)),
           new(Pr,label()),

        %new(Pregunta,text('¿ Ha estado en contacto con gotas de saliva o estornudos ?')),

	new(Pregunta_1,text('¿ Ha estado en contacto con gotas de saliva o estornudos ?')),
	send(Pregunta_1,alignment,left), %alinear el Pregunta_1 a la izquierda

	new(Pregunta_2,text('¿ Ha estado en contacto directo sin cubrebocas ?')),
	send(Pregunta_2,alignment,left), %alinear el Pregunta_2 a la izquierda

	new(Pregunta_3,text('¿ Ha tenido interaccion con objetos ?')),
	send(Pregunta_3,alignment,left), %alinear el Pregunta_3 a la izquierda

	new(Pregunta_4,text('¿ Ha sido picado por mosquitos ?')),
	send(Pregunta_4,alignment,left), %alinear el Pregunta_4 a la izquierda

        new(Title2,text(' Indica si presentas algun factor de riesgo ')),


        new(R_1, menu('',cycle)),
	new(R_2, menu('',cycle)),
	new(R_3, menu('',cycle)),
	new(R_4, menu('',cycle)),

        Respuestas_validas = ['NO','SI'],

	send_list(R_1, append, Respuestas_validas),
	send_list(R_2, append, Respuestas_validas),
	send_list(R_3, append, Respuestas_validas),
	send_list(R_4, append, Respuestas_validas),
        new(Grupo_de_Preguntas, dialog_group(texts, group)),
	send(Grupo_de_Preguntas, gap, size(0, 20)),%definimos el tamaño de la separacion de pregunta en pregunta

	%Enviamos cada pregunta al grupo correspondiente
	send(Grupo_de_Preguntas, append, Pregunta_1),
	send(Grupo_de_Preguntas, append, Pregunta_2),
	send(Grupo_de_Preguntas, append, Pregunta_3),
	send(Grupo_de_Preguntas, append, Pregunta_4),

        send(Ventana, append,Grupo_de_Preguntas),

        new(Grupo_de_Respuestas, dialog_group(menus, group)),
	send(Grupo_de_Respuestas, gap, size(0, 11)),%definimos el tamaño de la separacion de respuesta en respuesta

	%Enviamos cada respuesta al grupo correspondiente
	send(Grupo_de_Respuestas, append, R_1),
	send(Grupo_de_Respuestas, append, R_2),
	send(Grupo_de_Respuestas, append, R_3),
	send(Grupo_de_Respuestas, append, R_4),
        send(Ventana, append,Grupo_de_Respuestas,right),

        new(Evaluar, button('SIGUIENTE',and( message(@prolog,evaluar,
                                            Factores?selection,
                                            R_1?selection,
                                            R_2?selection,
                                            R_3?selection,
                                            R_4?selection,
                                            Pr),message(@prolog,sintomas,Pr?selection),message(Ventana,destroy)
                                           ))),

    send_list(Factores,append,[diabetes, asmatico, hipertenso,embarazada,obesidad,adulto_mayor, ninguno]),
    send(Ventana, append, Title2),
    send(Pr,colour,white),
    send(Ventana, append,Pr),
    send(Ventana, append,Factores),
    send(Ventana, append,Evaluar),
    send(Ventana, open_centered).



sintomas(Pr):-

       new(Principal, dialog('SINTOMAS')),% creamos el objeto de dialogo, referenciado a la variable Principal
       new(Titulo, text('Indica los sintomas que presentas')),%Creamos una etiqueta de texto
       new(MP,label()),
       send(Titulo, font, bold), % establecer en negritas el Titulo
       send(Titulo, alignment, center), %alinear el Titulo en el centro
       send(Titulo, colour, blue), %esteblecemos el color rojo para la etiqueta del Titulo
       send(Principal, append,Titulo), %mandamos la etiqueta Titulo al dialogo Principal para que se muestre
       send(MP,colour,moccasin),
       send(MP, append,Pr),
       send(Principal,append,MP),


	new(Pregunta_1,text('1.- ¿ tienes fatiga ?')),
	send(Pregunta_1,alignment,left), %alinear el Pregunta_1 a la izquierda

	new(Pregunta_2,text('2.- ¿ tienes dolor de pecho ?')),
	send(Pregunta_2,alignment,left), %alinear el Pregunta_2 a la izquierda

	new(Pregunta_3,text('3.- ¿ tienes diarrea ?')),
	send(Pregunta_3,alignment,left), %alinear el Pregunta_3 a la izquierda

	new(Pregunta_4,text('4.-¿ tienes tos seca o con flemas ?')),
	send(Pregunta_4,alignment,left), %alinear el Pregunta_4 a la izquierda

        new(Pregunta_5,text('5.- ¿ tienes dificultad respiratoria ?')),
	send(Pregunta_5,alignment,left), %alinear el Pregunta_4 a la izquierda

        new(Pregunta_6,text('6.- ¿ tienes dolor muscular o de articulaciones ?')),
	send(Pregunta_6,alignment,left), %alinear el Pregunta_4 a la izquierda

        new(Pregunta_7,text('7.- ¿ tienes malestar general ?')),
	send(Pregunta_7,alignment,left), %alinear el Pregunta_4 a la izquierda

        new(Pregunta_8,text('8.- ¿ tienes menor percepcion de olores y sabores ?')),
	send(Pregunta_8,alignment,left), %alinear el Pregunta_4 a la izquierda

        new(Pregunta_9,text('9.- ¿ tienes dolor de cabeza ?')),
	send(Pregunta_9,alignment,left), %alinear el Pregunta_4 a la izquierda

	new(Pregunta_10,text('10.- ¿ tienes fiebre ?')),
	send(Pregunta_10,alignment,left), %alinear el Pregunta_4 a la izquierda

        new(Pregunta_11,text('11.- ¿ tienes congestion nasal ?')),
	send(Pregunta_11,alignment,left), %alinear el Pregunta_4 a la izquierda

        new(Pregunta_12,text('12.- ¿ tienes dolor de garganta ?')),
	send(Pregunta_12,alignment,left), %alinear el Pregunta_4 a la izquierda

        new(Pregunta_13,text('13.- ¿ tienes intolerancia a la luz ?')),
	send(Pregunta_13,alignment,left), %alinear el Pregunta_4 a la izquierda

        new(Pregunta_14,text('14.- ¿ tienes perdida de apetito ?')),
	send(Pregunta_14,alignment,left), %alinear el Pregunta_4 a la izquierda

        new(Pregunta_15,text('15.- ¿ tienes dolor retroocular ?')),
	send(Pregunta_15,alignment,left), %alinear el Pregunta_4 a la izquierda

        new(Pregunta_16,text('16.- ¿ tienes sudoracion ?')),
	send(Pregunta_16,alignment,left), %alinear el Pregunta_4 a la izquierda

        new(Pregunta_17,text('17.- ¿ tienes escurrimiento nasal ?')),
	send(Pregunta_17,alignment,left), %alinear el Pregunta_4 a la izquierda

         new(Pregunta_18,text('18.- ¿ tienes estornudos ?')),
	send(Pregunta_18,alignment,left), %alinear el Pregunta_4 a la izquierda


	%listas para las respuestas
        new(R_1, menu('',cycle)),
	new(R_2, menu('',cycle)),
	new(R_3, menu('',cycle)),
	new(R_4, menu('',cycle)),
        new(R_5, menu('',cycle)),
        new(R_6, menu('',cycle)),
        new(R_7, menu('',cycle)),
        new(R_8, menu('',cycle)),
        new(R_9, menu('',cycle)),
        new(R_10, menu('',cycle)),
        new(R_11, menu('',cycle)),
        new(R_12, menu('',cycle)),
        new(R_13, menu('',cycle)),
        new(R_14, menu('',cycle)),
        new(R_15, menu('',cycle)),
        new(R_16, menu('',cycle)),
        new(R_17, menu('',cycle)),
        new(R_18, menu('',cycle)),



	%Agregamos el tipo de respuesta que se tiene que elejir SI o NO
	Respuestas_validas = ['NO','SI'],

	send_list(R_1, append, Respuestas_validas),
	send_list(R_2, append, Respuestas_validas),
	send_list(R_3, append, Respuestas_validas),
	send_list(R_4, append, Respuestas_validas),
	send_list(R_5, append, Respuestas_validas),
        send_list(R_6, append, Respuestas_validas),
        send_list(R_7, append, Respuestas_validas),
        send_list(R_8, append, Respuestas_validas),
        send_list(R_9, append, Respuestas_validas),
        send_list(R_10, append, Respuestas_validas),
        send_list(R_11, append, Respuestas_validas),
        send_list(R_12, append, Respuestas_validas),
        send_list(R_13, append, Respuestas_validas),
        send_list(R_14, append, Respuestas_validas),
        send_list(R_15, append, Respuestas_validas),
        send_list(R_16, append, Respuestas_validas),
        send_list(R_17, append, Respuestas_validas),
        send_list(R_18, append, Respuestas_validas),

	%Generamos un grupo de elementos de las preguntas solo por cuestiones de alineacion y diseño
	new(Grupo_de_Preguntas, dialog_group(texts, group)),
	send(Grupo_de_Preguntas, gap, size(0, 15)),%definimos el tamaño de la separacion de pregunta en pregunta

	%Enviamos cada pregunta al grupo correspondiente
	send(Grupo_de_Preguntas, append, Pregunta_1),
	send(Grupo_de_Preguntas, append, Pregunta_2),
	send(Grupo_de_Preguntas, append, Pregunta_3),
	send(Grupo_de_Preguntas, append, Pregunta_4),
        send(Grupo_de_Preguntas, append, Pregunta_5),
        send(Grupo_de_Preguntas, append, Pregunta_6),
        send(Grupo_de_Preguntas, append, Pregunta_7),
        send(Grupo_de_Preguntas, append, Pregunta_8),
        send(Grupo_de_Preguntas, append, Pregunta_9),
        send(Grupo_de_Preguntas, append, Pregunta_10),
        send(Grupo_de_Preguntas, append, Pregunta_11),
        send(Grupo_de_Preguntas, append, Pregunta_12),
        send(Grupo_de_Preguntas, append, Pregunta_13),
        send(Grupo_de_Preguntas, append, Pregunta_14),
        send(Grupo_de_Preguntas, append, Pregunta_15),
        send(Grupo_de_Preguntas, append, Pregunta_16),
        send(Grupo_de_Preguntas, append, Pregunta_17),
        send(Grupo_de_Preguntas, append, Pregunta_18),


	send(Principal, append,Grupo_de_Preguntas),% pasamos el grupo de preguntas al dialogo principal para que se visualize


	%realizamos lo mismo para los elementos de respuestas

	%Generamos un grupo de elementos de las respuestas solo por cuestiones de alineacion y diseño
	new(Grupo_de_Respuestas, dialog_group(menus, group)),
	send(Grupo_de_Respuestas, gap, size(0, 7)),%definimos el tamaño de la separacion de respuesta en respuesta

	%Enviamos cada respuesta al grupo correspondiente
	send(Grupo_de_Respuestas, append, R_1),
	send(Grupo_de_Respuestas, append, R_2),
	send(Grupo_de_Respuestas, append, R_3),
	send(Grupo_de_Respuestas, append, R_4),
        send(Grupo_de_Respuestas, append, R_5),
        send(Grupo_de_Respuestas, append, R_6),
        send(Grupo_de_Respuestas, append, R_7),
        send(Grupo_de_Respuestas, append, R_8),
        send(Grupo_de_Respuestas, append, R_9),
        send(Grupo_de_Respuestas, append, R_10),
        send(Grupo_de_Respuestas, append, R_11),
        send(Grupo_de_Respuestas, append, R_12),
        send(Grupo_de_Respuestas, append, R_13),
        send(Grupo_de_Respuestas, append, R_14),
        send(Grupo_de_Respuestas, append, R_15),
        send(Grupo_de_Respuestas, append, R_16),
        send(Grupo_de_Respuestas, append, R_17),
        send(Grupo_de_Respuestas, append, R_18),
	send(Principal, append,Grupo_de_Respuestas,right),% pasamos el grupo de respuestas al dialogo principal para que se visualize





	%Creamos un boton que nos servirar para evaluar cada respuesta de las preguntas
	new(Boton_Evaluar,button('EVALUAR',and(message(@prolog,evaluar,R_1?selection,
								       R_2?selection,
						                       R_3?selection,
						                       R_4?selection,
                                                                       R_5?selection,
                                                                       R_6?selection,
                                                                       R_7?selection,
                                                                       R_8?selection,
                                                                       R_9?selection,
                                                                       R_10?selection,
                                                                       R_11?selection,
                                                                       R_12?selection,
                                                                       R_13?selection,
                                                                       R_14?selection,
                                                                       R_15?selection,
                                                                       R_16?selection,
                                                                       R_17?selection,
                                                                       R_18?selection,
                                                                       MP?selection),
                                               message(Principal,destroy)))),

	send(Principal, append,Boton_Evaluar), %mandamos el Boton_Evaluar al dialogo Principal para que se muestre

	%abrimos el dialogo principal
        send(Principal,background,moccasin),
        send(Principal,open_centered).



%Regla para determinar el tipo de cesarea y de evaluacion
evaluar(R_1,R_2,R_3,R_4,R_5,R_6,R_7,R_8,R_9,R_10,R_11,R_12,R_13,R_14,R_15,R_16,R_17,R_18,MP) :-

	new(RESPUESTA, dialog('INFERENCIA')),% creamos el objeto de dialogo, referenciado a la variable Respuesta
	new(Titulo2, text('')),%Creamos una etiqueta de texto
	send(Titulo2, font, bold), % establecer en negritas el Titulo
	send(Titulo2, alignment, center), %alinear el Titulo en el centro
	send(Titulo2, colour, red), %esteblecemos el color rojo para la etiqueta del Titulo

	%obtenemos el valor que representa la respuesta seleccionada de cada pregunta (SI o NO)
	get(R_1, value , Res_1),
	get(R_2, value , Res_2),
	get(R_3, value , Res_3),
	get(R_4, value , Res_4),
	get(R_5, value , Res_5),
	get(R_6, value , Res_6),
	get(R_7, value , Res_7),
	get(R_8, value , Res_8),
	get(R_9, value , Res_9),
	get(R_10, value , Res_10),
	get(R_11, value , Res_11),
        get(R_12, value , Res_12),
        get(R_13, value , Res_13),
        get(R_14, value , Res_14),
        get(R_15, value , Res_15),
        get(R_16, value , Res_16),
        get(R_17, value , Res_17),
        get(R_18, value , Res_18),

       ( covid1(Res_2,Res_5,Res_8) -> new(Salida, text()),
         new(Btnincision,button('RECOMENDACIONES',and(message(@prolog,recomendacionesCovid),message(RESPUESTA,destroy)))),
         new(BtnExit, button('SALIR',and(message(RESPUESTA,destroy)))),
         new(Porcentaje, label()),
		       nueva_imagen(RESPUESTA,covid1,point(10,35)),
                       new(Titulo3, text('Usted tiene una probabilidad del')),%Creamos una etiqueta de texto
                       new(Titulo4, text('    % de padecer')),

                       send(Titulo3, font, bold), % establecer en negritas el Titulo
	               send(Titulo3, colour, red),
                       send(Titulo4, font, bold), % establecer en negritas el Titulo
	               send(Titulo4, colour, red),
                       send(Salida, font, bold),
                       send(Porcentaje, font, bold),
                       send(Porcentaje,colour,red),
                       send(Porcentaje,append,MP),
                       send(RESPUESTA, display,Titulo3,point(190, 7)),
                       send(RESPUESTA, display,Titulo4,point(418, 7)),
                       send(RESPUESTA,display,Porcentaje,point(408,7)),
                       send(RESPUESTA,display,BtnExit,point(170,175)),
                       send(RESPUESTA,display,Btnincision,point(20,175));

       ( covid2(Res_1,Res_3,Res_4,Res_6,Res_7,Res_9,Res_10) -> new(Salida, text()),
           new(Btnincision,button('RECOMENDACIONES',and(message(@prolog,recomendacionesCovid),message(RESPUESTA,destroy)))),
           new(BtnExit, button('SALIR',and(message(RESPUESTA,destroy)))),
           new(Porcentaje1, label()),
            nueva_imagen(RESPUESTA,covid1,point(10,35)),
           new(Titulo3, text('Usted tiene una probabilidad del')),%Creamos una etiqueta de texto
          new(Titulo4, text('   % de padecer')),
          send(Titulo3, font, bold), % establecer en negritas el Titulo
	  send(Titulo3, colour, red),
          send(Titulo4, font, bold), % establecer en negritas el Titulo
	  send(Titulo4, colour, red),
          send(Salida, font, bold),
          send(Porcentaje1, font, bold),
          send(Porcentaje1,colour,red),
          send(Porcentaje1,append,MP),
          send(RESPUESTA, display,Titulo3,point(190, 7)),
          send(RESPUESTA,display,Porcentaje1,point(408,7)),
          send(RESPUESTA, display,Titulo4,point(418, 7)),
          send(RESPUESTA,display,BtnExit,point(170,175)),
          send(RESPUESTA,display,Btnincision,point(20,175));

       ( resfriadoComun(Res_1,Res_4,Res_11,Res_12,Res_18) -> new(Salida, text()),
         new(Btnincision,button('RECOMENDACIONES', and(message(@prolog,recomendacionesResfriado),message(RESPUESTA,destroy)))),
          new(BtnExit, button('SALIR',and(message(RESPUESTA,destroy)))),
                       nueva_imagen(RESPUESTA,resfriadoc,point(10,35)),
          new(Titulo3, text('Usted padece')),%Creamos una etiqueta de texto
		       send(Salida, font, bold),
          send(RESPUESTA, display,Titulo3,point(190, 7)),
                       send(RESPUESTA,display,BtnExit,point(170,175)),
                       send(RESPUESTA,display,Btnincision,point(20,175));

       ( dengue(Res_1,Res_6,Res_7,Res_9,Res_10,Res_13,Res_14,Res_15,Res_16)  -> new(Salida, text()),
         new(Btnincision,button('RECOMENDACIONES',and(message(@prolog,recomendacionesDengue),message(RESPUESTA,destroy)))),
         new(BtnExit, button('SALIR',and(message(RESPUESTA,destroy)))),
		       nueva_imagen(RESPUESTA,dengue,point(10,35)),
          new(Titulo3, text('Usted padece')),%Creamos una etiqueta de texto
	               send(Salida, font, bold),
          send(RESPUESTA, display,Titulo3,point(190, 7)),
                       send(RESPUESTA,display,BtnExit,point(170,175)),
	               send(RESPUESTA,display,Btnincision,point(20,175));

       ( influenza(Res_1,Res_4,Res_7,Res_9,Res_10,Res_12,Res_17)  -> new(Salida, text()),
         new(Btnincision,button('RECOMENDACIONES',and(message(@prolog,recomendacionesInfluenza),message(RESPUESTA,destroy)))),
          new(BtnExit, button('SALIR',and(message(RESPUESTA,destroy)))),
		       nueva_imagen(RESPUESTA,influenza,point(10,35)),
                       new(Titulo3, text('Usted padece')),%Creamos una etiqueta de texto
	               send(Salida, font, bold),
          send(RESPUESTA, display,Titulo3,point(190, 7)),
                       send(RESPUESTA,display,BtnExit,point(170,175)),
                       send(RESPUESTA,display,Btnincision,point(20,175));

       ( neumonia(Res_2,Res_4,Res_5,Res_9,Res_10,Res_12)  -> new(Salida, text()),
         new(Btnincision,button('RECOMENDACIONES',and(message(@prolog,recomendacionesNeumonia),message(RESPUESTA,destroy)))),
          new(BtnExit, button('SALIR',and(message(RESPUESTA,destroy)))),
		      nueva_imagen(RESPUESTA,neumonia,point(10,35)),
                      new(Titulo3, text('Usted padece')),%Creamos una etiqueta de texto
	               send(Salida, font, bold),
          send(RESPUESTA, display,Titulo3,point(190, 7)),
                       send(RESPUESTA,display,BtnExit,point(170,175)),
                       send(RESPUESTA,display,Btnincision,point(20,175));

        new(Salida, text()),
        new(BtnReturn, button('REGRESAR', and(message(@prolog,iniciar),message(RESPUESTA,destroy)))),
        new(BtnExit, button('SALIR',and(message(RESPUESTA,destroy)))),
        nueva_imagen(RESPUESTA,desconocida,point(10,35)),
        send(RESPUESTA,display,BtnExit,point(140,175)),
        send(RESPUESTA,display,BtnReturn,point(20,175)),
        send(Salida, font, bold)
       )))))


       ),




	%send(RESPUESTA, append,Titulo2), %mandamos la etiqueta Titulo2 al dialogo Principal para que se muestre
	send(RESPUESTA, append,Salida), %mandamos la etiqueta Titulo al dialogo Principal para que se muestre
	send(RESPUESTA, open_centered). %mostramos el dialogo de la sugerencia en cuanto a la incision y la cesarea

covid1(Res_2,Res_5,Res_8):-(
                           Res_2 == 'SI',
                           Res_5 == 'SI',
                           Res_8 == 'SI').

covid2(Res_1,Res_3,Res_4,Res_6,Res_7,Res_9,Res_10):-(Res_1 == 'SI',
                                                     Res_3 == 'SI',
                                                     Res_4 == 'SI',
                                                     Res_6 == 'SI',
                                                     Res_7 == 'SI',
                                                     Res_9 == 'SI',
                                                     Res_10 == 'SI').

resfriadoComun(Res_1,Res_4,Res_11,Res_12,Res_18):-(Res_1 == 'SI',
                                                   Res_4 == 'SI',
                                                   Res_11 == 'SI',
                                                   Res_12 == 'SI',
                                                   Res_18 == 'SI').

dengue(Res_1,Res_6,Res_7,Res_9,Res_10,Res_13,Res_14,Res_15,Res_16):-(Res_1 == 'SI',
                                                                     Res_6 == 'SI',
                                                                     Res_7 == 'SI',
                                                                     Res_9 == 'SI',
                                                                     Res_10 == 'SI',
                                                                     Res_13 == 'SI',
                                                                     Res_14 == 'SI',
                                                                     Res_15 == 'SI',
                                                                     Res_16 == 'SI').


influenza(Res_1,Res_4,Res_7,Res_9,Res_10,Res_12,Res_17):-(Res_1 == 'SI',
                                                          Res_4 == 'SI',
                                                          Res_7 == 'SI',
                                                          Res_9 == 'SI',
                                                          Res_10 == 'SI',
                                                          Res_12 == 'SI',
                                                          Res_17 == 'SI').

neumonia(Res_2,Res_4,Res_5,Res_9,Res_10,Res_12):-(Res_2 == 'SI',
                                                  Res_4 == 'SI',
                                                  Res_5 == 'SI',
                                                  Res_9 == 'SI',
                                                  Res_10 == 'SI',
                                                  Res_12 == 'SI').




recomendacionesCovid:-new(Main, dialog('RECOMENDACIONES')),
       new(Title,text('
1. Desinfectar el hogar diariamente y objetos de uso personal,

2. Mantener una sana alimentacion y abundante ingesta de liquidos,

3. Lavado frecuente de manos,

4. No tener contacto directo con las demas personas,

5. Usar en todo momento el cubrebocas,

6. Buscar atencion medica de inmediato,

7. Permanecer en casa y aislarse incluso si presenta sintomas leves ')),
       new(Btnform,button('Registrar Paciente', and(message(@prolog,registro)))),
       new(BtnReturn, button('Regresar',and(message(@prolog,iniciar),message(Main,destroy)))),
       new(BtnExit, button('Salir',and(message(Main,destroy)))),
       send(Title,alignment, center),
       send(Title,font,bold),
       send(Title,colour,blue),
       nueva_imagen(Main,recomendaciones,point(0,0)),
       send(Main,display,Title,point(150,85)),
       send(Main,display,Btnform,point(170,320)),
       send(Main,display,BtnReturn,point(300,320)),
       send(Main,display,BtnExit,point(400,320)),
       send(Main,open_centered).

recomendacionesResfriado:-new(Main, dialog('RECOMENDACIONES')),
       new(Title,text('
1. Usar en todo momento el cubrebocas

2. Lavarse las manos depues de estornudar,toser o sonarse la nariz

3. Buscar atencion medica

4. Ajustar la temperatura y humedad de la habitacion, asi como desinfectar objetos

5. Mantener una sana alimentacion y abundante ingesta de liquidos

6. Quedarse en casa')),
       new(Btnform,button('Registrar Paciente', and(message(@prolog,registro)))),
       new(BtnReturn, button('Regresar',and(message(@prolog,iniciar),message(Main,destroy)))),
       new(BtnExit, button('Salir',and(message(Main,destroy)))),
       send(Title,alignment, center),
       send(Title,font,bold),
       send(Title,colour,blue),
       nueva_imagen(Main,recomendaciones,point(0,0)),
       send(Main,display,Title,point(150,85)),
       send(Main,display,Btnform,point(170,320)),
       send(Main,display,BtnReturn,point(300,320)),
       send(Main,display,BtnExit,point(400,320)),
       send(Main,open_centered).

recomendacionesDengue:-new(Main, dialog('RECOMENDACIONES')),
       new(Title,text('
1. Vestir ropa adecuada para reducir la temperatura corporal

2. Buscar atencion medica inmediatamente

3. Utilizar repelentes anti mosquitos

4. Uso de compresas para disminuir la fiebre

5. Mantener una sana alimentacion y abundante ingesta de liquidos')),
       new(Btnform,button('Registrar Paciente',and(message(@prolog,registro)))),
       new(BtnReturn, button('Regresar',and(message(@prolog,iniciar),message(Main,destroy)))),
       new(BtnExit, button('Salir',and(message(Main,destroy)))),
       send(Title,alignment, center),
       send(Title,font,bold),
       send(Title,colour,blue),
       nueva_imagen(Main,recomendaciones,point(0,0)),
       send(Main,display,Title,point(150,85)),
       send(Main,display,Btnform,point(170,320)),
       send(Main,display,BtnReturn,point(300,320)),
       send(Main,display,BtnExit,point(400,320)),
       send(Main,open_centered).

recomendacionesInfluenza:-new(Main, dialog('RECOMENDACIONES')),
       new(Title,text('
1. Mantener una sana alimentacion y abundante ingesta de liquidos

2. Mantener reposo

3. Lavarse las manos despues de estornudar,toser o sonarse la nariz

4. Usar en todo momento el cubrebocas

5. Buscar atencion medica inmediatamente')),
       new(Btnform,button('Registrar Paciente', and(message(@prolog,registro)))),
       new(BtnReturn, button('Regresar',and(message(@prolog,iniciar),message(Main,destroy)))),
       new(BtnExit, button('Salir',and(message(Main,destroy)))),
       send(Title,alignment, center),
       send(Title,font,bold),
       send(Title,colour,blue),
       nueva_imagen(Main,recomendaciones,point(0,0)),
       send(Main,display,Title,point(150,85)),
       send(Main,display,Btnform,point(170,320)),
       send(Main,display,BtnReturn,point(300,320)),
       send(Main,display,BtnExit,point(400,320)),
       send(Main,open_centered).

recomendacionesNeumonia:-new(Main, dialog('RECOMENDACIONES')),
       new(Title,text('
1. Mantenerse en casa durante los primeros 5 dias

2. Vestir ropa adecuada deacuerdo a la temperatura ambiente

3. Beber alrededor de 2 litros de agua por dia

4. Buscar atencion medica')),
       new(Btnform,button('Registrar Paciente', and(message(@prolog,registro)))),
       new(BtnReturn, button('Regresar',and(message(@prolog,iniciar),message(Main,destroy)))),
       new(BtnExit, button('Salir',and(message(Main,destroy)))),
       send(Title,alignment, center),
       send(Title,font,bold),
       send(Title,colour,blue),
       nueva_imagen(Main,recomendaciones,point(0,0)),
       send(Main,display,Title,point(150,85)),
       send(Main,display,Btnform,point(170,320)),
       send(Main,display,BtnReturn,point(300,320)),
       send(Main,display,BtnExit,point(400,320)),
       send(Main,background,lavender),
       send(Main,open_centered).

registro:-
    new(Di,dialog('Registrar Paciente')),

    send_list(Di,append,
   [new(Nombre,text_item(nombre)),
    new(Apellidos,text_item(apellidos)),
    new(Genero,new(menu(genero))),
    new(Edad, int_item(edad, low:=0, high:=100)),
    new(Fecha,text_item(fecha_de_consulta)),
    new(Enfermedad, new(menu(enfermedad,cycle))),
    new(Btnregreso, button(regresar, message(Di,destroy))),
    new(Btntest, button(registrar, and(message(@prolog, registro_paciente,
					       Nombre?selection,
                                               Apellidos?selection,
                                               Genero?selection,
                                               Edad?selection,
					       Fecha?selection,
                                               Enfermedad?selection
                                               ),message(@prolog,r_guardado,Di))))]),

    send_list(Genero,append, [masculino, femenino]),
    send_list(Enfermedad,append,[covid_19, influenza, neumonia, resfriado,dengue]),
    send(Di,background,lavender),
    send(Di,open_centered),
    send(Btntest, open),
    send(Btnregreso, open).


registro_paciente(Nombre,Apellidos,Genero,Edad,Fecha,Enfermedad):-
                            abrir_conexion,
                            odbc_query('prolog',"INSERT INTO paciente(nombre,apellidos,genero,edad,fecha_registro,enfermedad)VALUES('~w','~w','~w','~w','~w','~w');" -[Nombre,Apellidos,Genero,Edad,Fecha,Enfermedad]),
                            cerrar_conexion.

r_guardado(Di):- new(D,dialog),
           new(Texto, text('Datos Guardados')),
           new(B, button('OK',and(message(D,destroy),message(Di, destroy)))),
           send(Texto,font,bold),
	   send(Texto,colour,blue),
           send(D,append,Texto),
           send(D,display,B,point(50,50)),
           send(D,open_centered).

abrir_conexion:-
    odbc_connect('proyectoCovid',_,
               [user(root),
               password(''),
               alias(prolog),
               open(once)]).

cerrar_conexion:-
    odbc_disconnect('prolog').

evaluar(Factores,R_1,R_2,R_3,R_4,Pr):-

                         get(R_1, value,RES_1),
                         get(R_2, value,RES_2),
                         get(R_3, value,RES_3),
                         get(R_4, value,RES_4),
                         factor(Factores,P),
                         decicion(RES_1,RES_2,RES_3,RES_4,Res),
                         Porcentaje is P+Res,
                         send(Pr,append,Porcentaje).
                         %writeln(Porcentaje).



factor(Factor,P):-  get(Factor, value, Factor1),
                    Factor1 == 'diabetes',
                    P is 50;

                    get(Factor, value, Factor1),
                    Factor1 == 'asmatico',
                    P is 50;

                    get(Factor, value, Factor1),
                    Factor1 == 'hipertenso',
                    P is 50;

                    get(Factor, value, Factor1),
                    Factor1 == 'embarazada',
                    P is 50;

                    get(Factor, value, Factor1),
                    Factor1 == 'obesidad',
                    P is 50;

                    get(Factor, value, Factor1),
                    Factor1 == 'adulto_mayor',
                    P is 50;

                    get(Factor, value, Factor1),
                    Factor1 == 'ninguno',
                    P is 6.25.



decicion(R_1,R_2,R_3,R_4,Res):-
                         R_1 == 'SI',
                         R_2 == 'NO',
                         R_3 == 'NO',
                         R_4 == 'NO',
                         Res is 12.5;

                         R_1 == 'SI',
                         R_2 == 'NO',
                         R_3 == 'SI',
                         R_4 == 'NO',
                         Res is 25;

                         R_1 == 'SI',
                         R_2 == 'NO',
                         R_3 == 'NO',
                         R_4 == 'SI',
                         Res is 25;

                         R_1 == 'SI',
                         R_2 == 'SI',
                         R_3 == 'NO',
                         R_4 == 'NO',
                         Res is 25;

                         R_1 == 'NO',
                         R_2 == 'SI',
                         R_3 == 'SI',
                         R_4 == 'NO',
                         Res is 25;

                         R_1 == 'NO',
                         R_2 == 'SI',
                         R_3 == 'NO',
                         R_4 == 'SI',
                         Res is 25;
%//////////////////////////////////////// R_3

                         R_1 == 'SI',
                         R_2 == 'NO',
                         R_3 == 'SI',
                         R_4 == 'NO',
                         Res is 25;

                         R_1 == 'NO',
                         R_2 == 'SI',
                         R_3 == 'SI',
                         R_4 == 'NO',
                         Res is 25;

                         R_1 == 'NO',
                         R_2 == 'NO',
                         R_3 == 'SI',
                         R_4 == 'SI',
                         Res is 25;

%////////////////////////////////////////

%//////////////////////////////////////// R_4

                         R_1 == 'SI',
                         R_2 == 'NO',
                         R_3 == 'NO',
                         R_4 == 'SI',
                         Res is 25;

                         R_1 == 'NO',
                         R_2 == 'SI',
                         R_3 == 'NO',
                         R_4 == 'SI',
                         Res is 25;

                         R_1 == 'NO',
                         R_2 == 'NO',
                         R_3 == 'SI',
                         R_4 == 'SI',
                         Res is 25;

%////////////////////////////////////////
                         R_1 == 'SI',
                         R_2 == 'SI',
                         R_3 == 'NO',
                         R_4 == 'NO',
                         Res is 25;

                         R_1 == 'SI',
                         R_2 == 'SI',
                         R_3 == 'SI',
                         R_4 == 'NO',
                         Res is 37.5;

                         R_1 == 'SI',
                         R_2 == 'SI',
                         R_3 == 'SI',
                         R_4 == 'SI',
                         Res is 50;
% ----------------------------------------------------------

                         R_1 == 'NO',
                         R_2 == 'SI',
                         R_3 == 'NO',
                         R_4 == 'NO',
                         Res is 12.5;

                         R_1 == 'NO',
                         R_2 == 'SI',
                         R_3 == 'SI',
                         R_4 == 'NO',
                         Res is 25;

                         R_1 == 'NO',
                         R_2 == 'SI',
                         R_3 == 'SI',
                         R_4 == 'SI',
                         Res is 37.5;

%-----------------------------------------------------------

                         R_1 == 'NO',
                         R_2 == 'NO',
                         R_3 == 'SI',
                         R_4 == 'NO',
                         Res is 12.5;

                         R_1 == 'NO',
                         R_2 == 'NO',
                         R_3 == 'SI',
                         R_4 == 'SI',
                         Res is 25;

                         R_1 == 'SI',
                         R_2 == 'NO',
                         R_3 == 'SI',
                         R_4 == 'SI',
                         Res is 37.5;
%-----------------------------------------------------------

                         R_1 == 'NO',
                         R_2 == 'NO',
                         R_3 == 'NO',
                         R_4 == 'SI',
                         Res is 12.5;

                         R_1 == 'SI',
                         R_2 == 'NO',
                         R_3 == 'NO',
                         R_4 == 'SI',
                         Res is 25;

                         R_1 == 'SI',
                         R_2 == 'SI',
                         R_3 == 'NO',
                         R_4 == 'SI',
                         Res is 37.5;


%-----------------------------------------------------------

                         R_1 == 'NO',
                         R_2 == 'NO',
                         R_3 == 'NO',
                         R_4 == 'NO',
                         Res is 0.













