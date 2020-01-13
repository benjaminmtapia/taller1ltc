import numpy as np
import skfuzzy as fuzz
import matplotlib.pyplot as plt
from skfuzzy import control as ctrl


def Salida(calibre):
    salida = calibre - 17
    return str(salida)


def Reglas(forma, firmeza, cobertura, comercializacion):
    rule1 = ctrl.Rule(forma['Angosta'] & firmeza['Verde'] & cobertura['Leve'], comercializacion['Exportacion'])
    rule2 = ctrl.Rule(forma['Angosta'] & firmeza['Verde'] & cobertura['Parcial'], comercializacion['Comercial'])
    rule3 = ctrl.Rule(forma['Angosta'] & firmeza['Verde'] & cobertura['Completa'], comercializacion['Desecho'])
    rule4 = ctrl.Rule(forma['Angosta'] & firmeza['Madura'] & cobertura['Leve'], comercializacion['Exportacion'])
    rule5 = ctrl.Rule(forma['Angosta'] & firmeza['Madura'] & cobertura['Parcial'], comercializacion['Comercial'])
    rule6 = ctrl.Rule(forma['Angosta'] & firmeza['Madura'] & cobertura['Completa'], comercializacion['Desecho'])
    rule7 = ctrl.Rule(forma['Angosta'] & firmeza['Podrida'] & cobertura['Leve'], comercializacion['Desecho'])
    rule8 = ctrl.Rule(forma['Angosta'] & firmeza['Podrida'] & cobertura['Parcial'], comercializacion['Desecho'])
    rule9 = ctrl.Rule(forma['Angosta'] & firmeza['Podrida'] & cobertura['Completa'], comercializacion['Desecho'])
    rule10 = ctrl.Rule(forma['Normal'] & firmeza['Verde'] & cobertura['Leve'], comercializacion['Exportacion'])
    rule11 = ctrl.Rule(forma['Normal'] & firmeza['Verde'] & cobertura['Parcial'], comercializacion['Exportacion'])
    rule12 = ctrl.Rule(forma['Normal'] & firmeza['Verde'] & cobertura['Completa'], comercializacion['Desecho'])
    rule13 = ctrl.Rule(forma['Normal'] & firmeza['Madura'] & cobertura['Leve'], comercializacion['Exportacion'])
    rule14 = ctrl.Rule(forma['Normal'] & firmeza['Madura'] & cobertura['Parcial'], comercializacion['Exportacion'])
    rule15 = ctrl.Rule(forma['Normal'] & firmeza['Madura'] & cobertura['Completa'], comercializacion['Desecho'])
    rule16 = ctrl.Rule(forma['Normal'] & firmeza['Podrida'] & cobertura['Leve'], comercializacion['Desecho'])
    rule17 = ctrl.Rule(forma['Normal'] & firmeza['Podrida'] & cobertura['Parcial'], comercializacion['Desecho'])
    rule18 = ctrl.Rule(forma['Normal'] & firmeza['Podrida'] & cobertura['Completa'], comercializacion['Desecho'])
    rule19 = ctrl.Rule(forma['Ancha'] & firmeza['Verde'] & cobertura['Leve'], comercializacion['Exportacion'])
    rule20 = ctrl.Rule(forma['Ancha'] & firmeza['Verde'] & cobertura['Parcial'], comercializacion['Exportacion'])
    rule21 = ctrl.Rule(forma['Ancha'] & firmeza['Verde'] & cobertura['Completa'], comercializacion['Desecho'])
    rule22 = ctrl.Rule(forma['Ancha'] & firmeza['Madura'] & cobertura['Leve'], comercializacion['Exportacion'])
    rule23 = ctrl.Rule(forma['Ancha'] & firmeza['Madura'] & cobertura['Parcial'], comercializacion['Comercial'])
    rule24 = ctrl.Rule(forma['Ancha'] & firmeza['Madura'] & cobertura['Completa'], comercializacion['Desecho'])
    rule25 = ctrl.Rule(forma['Ancha'] & firmeza['Podrida'] & cobertura['Leve'], comercializacion['Desecho'])
    rule26 = ctrl.Rule(forma['Ancha'] & firmeza['Podrida'] & cobertura['Parcial'], comercializacion['Desecho'])
    rule27 = ctrl.Rule(forma['Ancha'] & firmeza['Podrida'] & cobertura['Completa'], comercializacion['Desecho'])
    return [rule1, rule2, rule3, rule4, rule5, rule6, rule7, rule8, rule9, rule10, rule11, rule12, rule13, rule14,
            rule15, rule16, rule17, rule18, rule19, rule20, rule21, rule22, rule23, rule24, rule25, rule26, rule27]


def Antecedentes():
    cobertura = ctrl.Antecedent(np.arange(0, 100, 5), 'cobertura')
    firmeza = ctrl.Antecedent(np.arange(0, 100, 5), 'firmeza')
    forma = ctrl.Antecedent(np.arange(0, 3.5), 'forma')

    cobertura['Leve'] = fuzz.trimf(cobertura.universe, [0, 15, 33])
    cobertura['Parcial'] = fuzz.trimf(cobertura.universe, [33, 45, 66])
    cobertura['Completa'] = fuzz.trimf(cobertura.universe, [66, 88, 100])

    forma['Angosta'] = fuzz.trapmf(forma.universe, [0, 0.5, 1, 1])
    forma['Normal'] = fuzz.trapmf(forma.universe, [1, 1.5, 2, 2])
    forma['Ancha'] = fuzz.trapmf(forma.universe, [2, 2.5, 3, 3.5])

    firmeza['Podrida'] = fuzz.trimf(firmeza.universe, [0, 15, 33])
    firmeza['Madura'] = fuzz.trimf(firmeza.universe, [33, 45, 66])
    firmeza['Verde'] = fuzz.trimf(firmeza.universe, [66, 88, 100])

    return cobertura, forma, firmeza


def Consecuente():
    comercializacion = ctrl.Consequent(np.arange(0, 100, 1), 'comercializacion')
    comercializacion['Desecho'] = fuzz.trimf(comercializacion.universe, [0, 15, 33])
    comercializacion['Comercial'] = fuzz.trimf(comercializacion.universe, [33, 45, 66])
    comercializacion['Exportacion'] = fuzz.trimf(comercializacion.universe, [66, 88, 100])

    return comercializacion


def recibirParametros():
    # altura, diametro, transparencia, cobertura
    altura = input("ingrese altura del fruto en mm: ")
    diametro = input("ingrese el diametro del fruto en mm: ")
    firmeza = input("ingrese la firmeza del fruto en % de fotoexposicion: ")
    cobertura = input("ingrese la cobertura de las manchas en %: ")
    return float(altura), float(diametro), float(firmeza), float(cobertura)


def escribirArchivo(calibre, forma, firmeza, cobertura, simulacion):
    valores_interpretados = interpretarPertenencia(forma, firmeza, cobertura, simulacion)

    nombreArchivo = "Cereza_" + str(calibre) + "_" + str(firmeza) + "_" + str(cobertura)+".txt"
    archivo = open(nombreArchivo, "w")
    archivo.write("Niveles capturados: \n")
    archivo.write("\tCalibre: " + str(calibre) + " mm\n")
    archivo.write("\tForma: " + valores_interpretados[0] + "\n")
    archivo.write("\tFirmeza de la Pulpa: " + valores_interpretados[1] + "\n")
    archivo.write("\tCobertura de manchas: " + valores_interpretados[2] + "\n")
    archivo.write("Comercializacion: " + valores_interpretados[3] + "\n")
    archivo.write("Numero de Salida: " + Salida(calibre) + "\n")


def graficarResultados(cobertura, forma, firmeza, comercializacion,simulacion):

    # Graficar antecedentes
    cobertura.view(sim=simulacion)
    forma.view(sim=simulacion)
    firmeza.view(sim=simulacion)

    # Grafica de consecuente
    comercializacion.view(sim=simulacion)
    plt.show()


def interpretarPertenencia(forma, firmeza, cobertura, simulacion):
    resultado = simulacion.output['comercializacion']
    #Interpretar Forma
    if forma <= 1:
        forma_output = "Angosta"
    elif forma > 1 and forma <= 2:
        forma_output = "Normal"
    else:
        forma_output = "Ancha"

    # Interpretar firmeza
    if firmeza <= 33:
        firmeza_output = "Verde"
    elif firmeza > 33 and firmeza <= 66:
        firmeza_output = "Madura"
    else:
        firmeza_output = "Podrida"

    # Interpretar cobertura
    if cobertura <= 33:
        cobertura_output = "Leve"
    elif cobertura > 33 and cobertura <= 66:
        cobertura_output = "Parcial"
    else:
        cobertura_output = "Completa"

    # Interpretar comercializacion
    if resultado <= 33:
        comercializacion_output = "Desecho"
    elif resultado >= 33 and resultado < 66:
        comercializacion_output = "Comercial"
    else:
        comercializacion_output = "Exportable"

    return forma_output, firmeza_output, cobertura_output, comercializacion_output


def fusificar(input_forma, input_firmeza, input_cobertura):
    # Definición de antecedentes y consecuentes
    cobertura, forma, firmeza = Antecedentes()
    comercializacion = Consecuente()

    # Almacenar las reglas
    reglas = Reglas(forma, firmeza, cobertura, comercializacion)

    # Aplicar las reglas
    aplicacionReglas = ctrl.ControlSystem(reglas)

    # Fusificación
    simular = ctrl.ControlSystemSimulation(aplicacionReglas)

    simular.input['forma'] = input_forma
    simular.input['firmeza'] = input_firmeza
    simular.input['cobertura'] = input_cobertura
    simular.compute()

    # Graficar Resultados
    graficarResultados(cobertura, forma, firmeza, comercializacion, simular)

    return simular


def main():
    # Ingreso de parámetros por pantalla
    input_altura, input_diametro, input_firmeza, input_cobertura = recibirParametros()
    input_forma = input_diametro / input_altura


    # Fusificacion y gráficos
    fusificacion = fusificar(input_forma, input_firmeza, input_cobertura)


    # Escribir el archivo de salida
    escribirArchivo(input_diametro, input_forma, input_firmeza, input_cobertura, fusificacion)


# Ejecución del programa
main()
