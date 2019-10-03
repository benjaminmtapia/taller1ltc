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
cobertura("bajo").

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
%cereza(PER,COL,MAN,COB,TAM,PES,DUR,TEX,PED,CIC,DOB).

%Predicados
add_tail([],X,[X]).
add_tail([H|T],X,[H|L]):-add_tail(T,X,L).


frutoArrugado(_,_,_,_,_,_,_,TEX,_,_,_,"fruto arrugado"):- textura(TEX), TEX == "rugosa". 
machucon(_,_,MAN,_,_,_,DUR,TEX,_,_,_,"machucon"):-mancha(MAN),
                                            dureza(DUR),
                                            DUR=="baja",
                                            textura(TEX), TEX=="rugosa".
sinColor(_,COL,_,_,_,_,_,_,_,_,_,"sin color"):- coloracion(COL),
                                             COL == "rosada". 

magulladura(PER,_,_,_,_,_,_,_,_,_,_,"magulladura"):-PER =="si",
                                perforacion(PER).

frutoDoble(_,_,_,_,_,PES,_,_,_,_,DOB,"fruto doble"):-doble(DOB),
                                                        DOB=="si",
                                                         peso(PES),
                                                          PES=="alto".

pedunculo(_,_,_,_,_,_,_,_,PED,_,_,"pedunculo"):- pedunculo(PED), PED == "si". 

frutoGemelo(_,_,_,_,_,_,_,_,TEX,_,DOB,"fruto gemelo"):- doble(DOB),
                                        DOB == "si", 
                                        textura(TEX), 
                                        TEX == "rugosa".

madurezExcesiva(_,COL,_,_,TAM,PES,DUR,_,_,_,_,"madurez excesiva"):-coloracion(COL),
                                            tamano(TAM),
    										peso(PES),
    										dureza(DUR),
                                            DUR=="baja",
                                            COL == "negra" ; COL == "purpura",
    										TAM == "grande",
    										PES == "alto".

cicatriz(_,_,_,COB,_,_,_,_,_,CIC,_,"cicatriz"):-cobertura(COB),
                                     cicatriz(CIC),
                                     COB=="baja",
    								 CIC == "si".

partiduraCicatrizada(_,_,_,_,_,_,_,_,_,CIC,_,PAR):- cicatriz(CIC),
                                                    CIC == "si", 
                                                    partidura(PAR), 
                                                    PAR == "si".
perforacionCicatrizada(PER,_,_,_,_,_,_,CIC,_,_,"perforacion cicatrizada"):-perforacion(PER),
                                                    per=="si",
                                                    cicatriz(CIC),
                                                    CIC=="si".

detectarDefectos(PER,COL,MAN,COB,TAM,PES,DUR,TEX,PED,CIC,DOB,B):-machucon(PER,COL,MAN,COB,TAM,PES,DUR,TEX,PED,CIC,DOB,MACHUCON),
                                                                    add_tail([_|_],MACHUCON,A),
                                                                    sinColor(_,COL,_,_,_,_,_,_,_,_,_,SINCOLOR),
                                                                    add_tail(A,SINCOLOR,B).