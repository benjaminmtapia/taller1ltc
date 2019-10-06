%Base de conocimiento
%hechos
esFruta("cereza").
esFruta("frutilla").
esFruta("manzana").

%fallas
fallas("machucon").
fallas("cicatriz").
fallas("magulladura").
fallas("medialuna").
fallas("sin color").
fallas("fruto arrugado").
fallas("madurez excesiva").
fallas("perforacion cicatrizada").
fallas("quemadura solar").
fallas("sin pedunculo").

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

%Predicados
add_tail(X,"no",X):-!.
add_tail([],X,[X]).
add_tail([H|T],X,[H|L]):- add_tail(T,X,L).



%DETECCIÓN DE DEFECTOS
frutoArrugado(TEX,X):- ((textura(TEX), TEX == "rugosa") -> X = "fruto arrugado";
                                                           X = "no"). 

machucon(MAN,DUR,TEX,X):- ((mancha(MAN),
                        dureza(DUR),
                        DUR == "baja",
                        textura(TEX), TEX == "rugosa") -> X = "machucon";
                                                          X = "no").

sinColor(COL,X):- ((coloracion(COL), COL == "rosada") -> X = "sin color";
                                                         X = "no"). 

magulladura(PER,X):- ((perforacion(PER),PER == "si") -> X = "magulladura";
                                                        X = "no" ).

frutoDoble(PES,DOB,X):- ((doble(DOB), DOB=="si",
                                      peso(PES),
                                      PES=="alto") -> X = "fruto doble";
                                                      X = "no").

pedunculo(PED,X):- ((pedunculo(PED), PED == "si") -> X = "sin pedunculo";
                                                     X = "no"). 

frutoGemelo(TEX,DOB,X):- ((doble(DOB), DOB == "si", 
                                       textura(TEX), 
                                       TEX == "rugosa") -> X = "fruto gemelo";
                                                           X ="no").

madurezExcesiva(COL,TAM,PES,DUR,X):-((coloracion(COL),tamano(TAM),peso(PES),
                                    dureza(DUR),DUR=="baja", (COL == "negra"; 
                                    COL == "purpura"),TAM == "grande",
                                    PES == "alto")-> X = "madurez excesiva";
                                                     X = "no").

cicatriz(COB,CIC,X):-((cobertura(COB), COB == "baja",
                       cicatriz(CIC), CIC == "si") -> X = "cicatriz";
                                                     X = "no").

partiduraCicatrizada(CIC,PAR,X):- ((cicatriz(CIC),
                                  CIC == "si", 
                                  partidura(PAR), 
                                  PAR == "si") -> X = "partidura cicatrizada";
                                                  X = "no").

perforacionCicatrizada(PER,CIC,X):- ((perforacion(PER),
                                    per=="si",
                                    cicatriz(CIC),
                                    CIC=="si") -> X = "perforacion cicatrizada";
                                                  X = "no").

detectarDefectos(PER,COL,MAN,TAM,PES,DUR,TEX,PED,[CIC,COB],DOB,PAR,L):- 
                                    frutoArrugado(TEX,A), add_tail([],A,L1),
                                    machucon(MAN,DUR,TEX,B), add_tail(L1,B,L2),
                                    sinColor(COL,C), add_tail(L2,C,L3),
                                    magulladura(PER,D), add_tail(L3,D,L4),
                                    frutoDoble(PES,DOB,E),add_tail(L4,E,L5),
                                    pedunculo(PED,F), add_tail(L5,F,L6),
                                    madurezExcesiva(COL,TAM,PES,DUR,G), add_tail(L6,G,L7),
                                    cicatriz(COB,CIC,H),add_tail(L7,H,L8),
                                    partiduraCicatrizada(CIC,PAR,I), add_tail(L8,I,L9),
                                    perforacionCicatrizada(PER,CIC,J), add_tail(L9,J,L).
