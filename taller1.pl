%Base de conocimiento
perforacion("si").
perforacion("no").

coloracion("rosada").
coloracion("verde").
coloracion("roja").
coloracion("negra").
coloracion("purpura").

mancha("russet").
mancha("quemadura de sol").

cobertura("alto").
cobertura("medio").
cobertura("baja").

tamano("grande").
tamano("medio").
tamano("pequeno").

peso("bajo").
peso("normal").
peso("alto").

dureza("alta").
dureza("adecuada").
dureza("baja").

textura("rugosa").
textura("lisa").

pedunculo("si").
pedunculo("no").

doble("si").
doble("no").

cicatriz("si").
cicatriz("no").

partidura("si").
partidura("no").

calibre(1,18).
calibre(2,19).
calibre(3,20).
calibre(4,21).
calibre(5,22).
calibre(6,23).
calibre(7,24).
calibre(8,25).
calibre(9,26).
calibre(10,27).
calibre(11,28).
calibre(12,29).
calibre(13,30).
calibre(14,31).
calibre(15,32).
calibre(16,"desecho").


%machucon debe estar manchada, rugosa y blanda LISTO
%cicatriz solo eso                             LISTO
%pedunculo solo pedunculo                      LISTO
%magulladura perforada                         LISTO
%perforacion cicatrizada solo eso              LISTO
%fruto gemelo tiene otro fruto y arrugado      LISTO
%fruto doble peso alto, arrugado, normal       LISTO
%sin color, color rosado                       LISTO
%fruto arrugado piel rugosa                    LISTO
%madurez excesiva, solo eso                    LISTO
%partidura cicatrizada, partido y cicatriz     LISTO

%perforacion, color, mancha, cobertura, tamano, peso, dureza, textura, pedunculo, cicatriz, doble
%cereza(PER,COL,MAN,TAM,PES,DUR,TEX,PED,[CIC,COB],DOB,PAR,L)

%CLAUSULAS DE HORN

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

%DETECCIÓN DE DEFECTOS
frutoArrugado(TEX,DEFECTO):- ((textura(TEX), TEX == "rugosa") -> DEFECTO = "fruto arrugado";
                                                                 DEFECTO = "no"). 

machucon(MAN,DUR,TEX,DEFECTO):- ((mancha(MAN),
                        dureza(DUR),
                        DUR == "baja",
                        textura(TEX), TEX == "rugosa") -> DEFECTO = "machucon";
                                                          DEFECTO = "no").

sinColor(COL,DEFECTO):- ((coloracion(COL), COL == "rosada") -> DEFECTO = "sin color";
                                                               DEFECTO = "no"). 

magulladura(PER,DEFECTO):- ((perforacion(PER),PER == "si") -> DEFECTO = "magulladura";
                                                        DEFECTO = "no" ).

frutoDoble(PES,DOB,DEFECTO):- ((doble(DOB), DOB=="si",
                                      peso(PES),
                                      PES=="alto") -> DEFECTO = "fruto doble";
                                                      DEFECTO = "no").

pedunculo(PED,DEFECTO):- ((pedunculo(PED), PED == "si") -> DEFECTO = "sin pedunculo";
                                                     DEFECTO = "no"). 

frutoGemelo(TEX,DOB,DEFECTO):- ((doble(DOB), DOB == "si", 
                                       textura(TEX), 
                                       TEX == "rugosa") -> DEFECTO = "fruto gemelo";
                                                           DEFECTO ="no").

madurezExcesiva(COL,TAM,PES,DUR,DEFECTO):-((coloracion(COL),tamano(TAM),peso(PES),
                                    dureza(DUR),DUR=="baja", (COL == "negra"; 
                                    COL == "purpura"),TAM == "grande",
                                    PES == "alto")-> DEFECTO = "madurez excesiva";
                                                     DEFECTO = "no").

cicatriz(COB,CIC,DEFECTO):-((cobertura(COB), COB == "baja",
                       cicatriz(CIC), CIC == "si") -> DEFECTO = "cicatriz";
                                                      DEFECTO = "no").

partiduraCicatrizada(CIC,PAR,DEFECTO):- ((cicatriz(CIC),
                                  CIC == "si", 
                                  partidura(PAR), 
                                  PAR == "si") -> DEFECTO = "partidura cicatrizada";
                                                  DEFECTO = "no").

perforacionCicatrizada(PER,CIC,DEFECTO):- ((perforacion(PER),
                                              PER=="si",
                                              cicatriz(CIC),
                                              CIC=="si") -> DEFECTO="perforacion cicatrizada"; DEFECTO="no").

quemaduraSolar(COL,DEFECTO):-coloracion(COL) -> DEFECTO = "quemadura solar"; DEFECTO="no".

detectarDefectos(PER,COL,MAN,TAM,PES,DUR,TEX,PED,[CIC,COB],DOB,PAR,L):- 
                                    frutoArrugado(TEX,A), 
                                    add_tail([],A,L1),
                                    machucon(MAN,DUR,TEX,B), 
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
                                    quemaduraSolar(COL,K),
                                    add_tail(L10,K,L).
