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
fallas("herida cicatrizada").
fallas("perforacion cicatrizada").
fallas("quemadura solar").
fallas("sin pedunculo").

perforacion("si").
perforacion("no").

coloracion("rosada").
coloracion("verde").
coloracion("roja").
coloracion("negra").

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


%machucon debe estar manchada, rugosa y blanda LISTO
%cicatriz solo eso
%pedunculo solo pedunculo                      LISTO
%magulladura perforada
%perforacion cicatrizada solo eso
%fruto gemelo tiene otro fruto y arrugado
%fruto doble peso alto, arrugado, normal
%sin color, color rosado                       LISTO
%fruto arrugado piel rugosa                    LISTO
%madurez excesiva, solo eso


%cereza(PER,COL,MAN,COB,TAM,PES,DUR,TEX,PED,DOB).

%Predicados
frutoArrugado(_,_,_,_,_,_,_,TEX,_):- textura(TEX), TEX == "rugosa". 
machucon(_,_,MAN,_,_,_,DUR,TEX,_,"machucon"):-mancha(MAN),
                                            dureza(DUR),
                                            DUR=="baja",
                                            textura(TEX), TEX=="rugosa".
sinColor(_,COL,_,_,_,_,_,_,_,"sin color"):- coloracion(COL), COL == "rosada". 

magulladura(PER,_,_,_,_,_,_,_,_):-PER =="si", perforacion(PER).

frutoDoble(_,_,_,_,_,_,PES,_,)

pedunculo(_,_,_,_,_,_,_,_,PED):- pedunculo(PED), PED == "si". 

frutoGemelo(_,_,_,_,_,_,_,TEX,_,DOB):- doble(DOB), DOB == "si", textura(TEX), TEX == "rugosa".