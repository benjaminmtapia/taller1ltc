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



%machucon debe estar manchada, rugosa y blanda
%cicatriz solo eso
%pedunculo solo pedunculo
%magulladura perforada
%perforacion cicatrizada solo eso
%fruto gemelo tiene otro fruto y arrugado
%fruto doble peso alto, arrugado, normal
%sin color, color rosado
%fruto arrugado piel rugosa
%madurez excesiva, solo eso


%cereza(PER,COL,MAN,COB,TAM,PES,DUR,TEX,PED).

%Predicados
frutoArrugado(_,_,_,_,_,_,_,TEX,_):- textura(TEX), TEX == "rugosa". 
machucon(_,_,MAN,_,_,_,DUR,TEX,_,"machucon"):-mancha(MAN),dureza(DUR),textura(TEX).