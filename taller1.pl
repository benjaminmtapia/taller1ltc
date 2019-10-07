%Taller 1 hecho por Maximiliano Arevalo, Valentina Ligueño, Nicolas Lopez y Benjamin Muñoz

%##########################################################################################

%Base de conocimiento

%Determinar si una cereza tiene perforacion
perforacion("si").
perforacion("no").

%Determinar la coloracion de una cereza
coloracion("rosada").
coloracion("verde").
coloracion("roja").
coloracion("negra").
coloracion("purpura").

%Determinar si una cereza tiene mancha
mancha("no").
mancha("quemadura de sol").
mancha("russet").

%Determinar la cobertura de la mancha en una cereza
cobertura("alto").
cobertura("medio").
cobertura("baja").

%Determinar el tamano de la cicatriz de la cereza
tamano("grande").
tamano("medio").
tamano("pequeno").

%Determinar el peso de la cereza
peso("bajo").
peso("normal").
peso("alto").

%Determinar la dureza de la cereza
dureza("alta").
dureza("adecuada").
dureza("baja").

%Determinar la textura de la cereza
textura("rugosa").
textura("lisa").

%Determinar si una cereza tiene pedunculo
pedunculo("si").
pedunculo("no").

%Determinar si una cereza tiene fruto doble
doble("si").
doble("no").

%Determinar si una cereza tiene cicatriz
cicatriz("si").
cicatriz("no").

%Determinar si una cereza posee partidura
partidura("si").
partidura("no").

%Determinar el calibre, tamano y salida de una cereza determinada
%De la forma calibre(salida,diametro,tamano)
calibre(1,18,"pequeño").
calibre(2,19,"pequeño").
calibre(3,20,"pequeño").
calibre(4,21,"pequeño").
calibre(5,22,"pequeño").
calibre(6,23,"mediano").
calibre(7,24,"mediano").
calibre(8,25,"mediano").
calibre(9,26,"mediano").
calibre(10,27,"mediano").
calibre(11,28,"grande").
calibre(12,29,"grande").
calibre(13,30,"grande").
calibre(14,31,"muy grande").
calibre(15,32,"muy grande").
calibre(16,"desecho","muy grande").

%##########################################################################################

%Supuestos para la consideracion de defectos

%machucon debe estar manchada, rugosa y blanda 
%magulladura perforada                         
%perforacion cicatrizada solo eso              
%fruto gemelo tiene otro fruto y arrugado      
%fruto doble peso alto, arrugado, normal       
%sin color, color rosado                       
%fruto arrugado piel rugosa                    
%madurez excesiva, solo eso                    
%partidura cicatrizada, partido y cicatriz     
%perforacion, color, mancha, cobertura, tamano, peso, dureza, textura, pedunculo, doble, cicatriz, partidura
%quemadura solar debe poseer una mancha por quemadura solar

%Representacion de una cereza del tipo: cereza(PER,COL,MAN,TAM,PES,DUR,TEX,PED,[CIC,COB],DOB,PAR,L)

%##########################################################################################

%Clausulas de Horn

%auxiliar para agregar elemento al final de una lista
%fuente: https://stackoverflow.com/questions/15028831/how-do-you-append-an-element-to-a-list-in-place-in-prolog
add_tail(X,"no",X):-!.
add_tail([],X,[X]).
add_tail([H|T],X,[H|L]):- add_tail(T,X,L).

%auxiliar para realizar delete mapping en una lista
%fuente https://www2.cs.arizona.edu/~collberg/Teaching/372/2005/Html/Html-21/
delete_all(_, [], []).
delete_all(X, [X|Xs], Y) :-
    delete_all(X, Xs, Y).
delete_all(X, [T|Xs], [T|Y]) :-
    dif(X, T),
    delete_all(X, Xs, Y).


%Deteccion de defectos

%Entrada: Una cereza con sus respectivos parametros
%Procedimiento: Valida los parametros que tiene la cereza
%Salida: La cereza como tal
cereza(PER,COL,MAN,TAM,PES,DUR,TEX,PED,CIC,DOB,PAR):- perforacion(PER), coloracion(COL),mancha(MAN), 
                                                      tamano(TAM),peso(PES), dureza(DUR), textura(TEX),
                                                      pedunculo(PED), cicatriz(CIC), doble(DOB), partidura(PAR).

%Entrada: Parametros requeridos para la deteccion del defecto en la cereza
%Procedimiento: Verifica la textura de la cereza 
%Salida: Si la textura es rugosa, la cereza esta arrugada
frutoArrugado(TEX,DEFECTO):- ((TEX == "rugosa") -> DEFECTO = "fruto arrugado";
                                                   DEFECTO = "no"). 

%Entrada: Parametros requeridos para la deteccion del defecto en la cereza
%Procedimiento: Verifica la dureza y la textura de la cereza
%Salida: Si la dureza es baja y la textura es rugosa, la cereza posee un machucon
machucon(DUR,TEX,DEFECTO):- ((DUR == "baja",
                             TEX == "rugosa") -> DEFECTO = "machucon";
                                                 DEFECTO = "no").

%Entrada: Parametros requeridos para la deteccion del defecto en la cereza
%Procedimiento: Verifica la coloracion de la cereza
%Salida: Si la coloracion es rosada, la cereza no posee color
sinColor(COL,DEFECTO):- ((COL == "rosada") -> DEFECTO = "sin color";
                                              DEFECTO = "no"). 

%Entrada: Parametros requeridos para la deteccion del defecto en la cereza
%Procedimiento: Verifica si una cereza posee perforacion
%Salida: Si hay perforacion, la cereza posee una magulladura perforada
magulladura(PER,DEFECTO):- ((PER == "si") -> DEFECTO = "magulladura perforada";
                                                        DEFECTO = "no" ).

%Entrada: Parametros requeridos para la deteccion del defecto en la cereza
%Procedimiento: Verifica el peso y la existencia de un fruto doble en una cereza
%Salida: Si existe un fruto doble y el peso de la cereza es alto, la cereza posee un fruto doble
frutoDoble(PES,DOB,DEFECTO):- ((DOB=="si", PES=="alto") -> DEFECTO = "fruto doble";
                                                           DEFECTO = "no").

%Entrada: Parametros requeridos para la deteccion del defecto en la cereza
%Procedimiento: Verificar la existencia de pedunculo en una cereza
%Salida: Si no hay pedunculo, la cereza es sin pedunculo
pedunculo(PED,DEFECTO):- ((PED == "si") -> DEFECTO = "sin pedunculo";
                                           DEFECTO = "no"). 

%Entrada: Parametros requeridos para la deteccion del defecto en la cereza
%Procedimiento: Verifica la textura y la existencia de fruto doble en la cereza
%Salida: Si existe fruto doble y la textura es rugosa, la cereza tiene fruto gemelo
frutoGemelo(TEX,DOB,DEFECTO):- ((DOB == "si",  
                                 TEX == "rugosa") -> DEFECTO = "fruto gemelo";
                                                           DEFECTO ="no").

%Entrada: Parametros requeridos para la deteccion del defecto en la cereza
%Procedimiento: Verifica la coloracion, el tamaño, el peso y la dureza de una cereza
%Salida: Si la dureza es baja, la coloracion es negra o purpura, el tamaño es grande y su peso es alto. Entonces, la cereza tiene madurez excesiva
madurezExcesiva(COL,TAM,PES,DUR,DEFECTO):-((dureza(DUR),DUR=="baja", (COL == "negra"; 
                                            COL == "purpura"),TAM == "grande",
                                            PES == "alto") -> DEFECTO = "madurez excesiva";
                                                              DEFECTO = "no").

%Entrada: Parametros requeridos para la deteccion del defecto en la cereza
%Procedimiento: Verifica la cobertura y la cicatriz de una cereza
%Salida: Si la cobertura es baja y existe cicatriz, entonces la cereza tiene cicatriz
cicatriz(COB,CIC,DEFECTO):-((COB == "baja",
                             CIC == "si") -> DEFECTO = "cicatriz";
                                             DEFECTO = "no").

%Entrada: Parametros requeridos para la deteccion del defecto en la cereza
%Procedimiento: Verifica si una cereza tiene cicatriz y partidura
%Salida: Si tiene cicatriz y partidura, entonces la cereza tiene partidura cicatrizada
partiduraCicatrizada(CIC,PAR,DEFECTO):- ((CIC == "si", 
                                          PAR == "si") -> DEFECTO = "partidura cicatrizada";
                                                          DEFECTO = "no").

%Entrada: Parametros requeridos para la deteccion del defecto en la cereza
%Procedimiento: Verifica si una cereza tiene cicatriz y perforacion
%Salida: Si tiene cicatriz y perforacion, entonces la cereza tiene perforacion cicatrizada
perforacionCicatrizada(PER,CIC,DEFECTO):- ((PER=="si",
                                            CIC=="si") -> DEFECTO="perforacion cicatrizada"; 
                                                          DEFECTO="no").

%Entrada: Parametros requeridos para la deteccion del defecto en la cereza
%Procedimiento: Verifica la mancha de una cereza
%Salida: Si la mancha es solar, entonces la cereza tiene quemadura de sol
quemaduraSolar(MAN,DEFECTO):- ((MAN == "quemadura de sol") -> DEFECTO = "quemadura solar"; 
                                                              DEFECTO = "no").

%Entrada: Parametros requeridos para la deteccion del defecto en la cereza
%Procedimiento: Comprueba la existencia de todos los defectos para una cereza en particular, y los agrega en una lista
%Salida: Lista con los defectos encontrados para una cereza en particular
detectarDefectos(PER,COL,MAN,TAM,PES,DUR,TEX,PED,[CIC,COB],DOB,PAR,L):-
                                    cereza(PER,COL,MAN,TAM,PES,DUR,TEX,PED,CIC,DOB,PAR) ->
                                    (frutoArrugado(TEX,A), 
                                    add_tail([],A,L1),
                                    machucon(DUR,TEX,B), 
                                    add_tail(L1,B,L2),
                                    sinColor(COL,C), 
                                    add_tail(L2,C,L3),
                                    magulladura(PER,D), 
                                    add_tail(L3,D,L4),
                                    frutoDoble(PES,DOB,E),
                                    add_tail(L4,E,L5),
                                    pedunculo(PED,F),
                                    add_tail(L5,F,L6),
                                    madurezExcesiva(COL,TAM,PES,DUR,G),
                                    add_tail(L6,G,L7),
                                    cicatriz(COB,CIC,H),
                                    add_tail(L7,H,L8),
                                    partiduraCicatrizada(CIC,PAR,I),
                                    add_tail(L8,I,L9),
                                    perforacionCicatrizada(PER,CIC,J),
                                    add_tail(L9,J,L10),
                                    quemaduraSolar(MAN,K),
                                    add_tail(L10,K,L)); write("Alguna caracteristica esta mal ingresada, verifique e intente nuevamente").

%Entrada: Una cereza con todos sus parametros, el diametro de esta y una variable de salida
%Procedimiento: Detecta los defectos de una cereza, y en base a su numero de defectos y tamaño retorna su linea de embalaje respectiva
%Salida: Linea de embalaje y si la fruta es exportable, fruto comercial o desecho
salidaEmbalaje(PER,COL,MAN,TAM,PES,DUR,TEX,PED,[CIC,COB],DOB,PAR,DIAMETRO,SALIDA):-
                  detectarDefectos(PER,COL,MAN,TAM,PES,DUR,TEX,PED,[CIC,COB],DOB,PAR,L),
                  length(L,CANTIDADDEFECTOS),
                  calibre(LINEA,DIAMETRO,TAMANO),
                  (( TAMANO\=="pequeño", CANTIDADDEFECTOS=<1 )->  SALIDA ="exportacion";(
                   (TAMANO=="pequeño", CANTIDADDEFECTOS=<2)-> SALIDA ="fruto comercial";(
                          (CANTIDADDEFECTOS>=3)->SALIDA ="desecho"
                      )
                  )),
                  string_concat("linea: ",LINEA,B),
                  write(B).
                  