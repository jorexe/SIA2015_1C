mperceptron(n,lengthOut,hidenN, iterations, rate, g, gDerivada):
	PARAMS:
		n : longitud de la entrada, en nuestro caso 1.
		lengthOut : longitud de salida , en nuestro caso 1.
		hidenN: cantidad de neuronas en la capa oculta.
		iterations : cantidad de epocas que quiero.
		rate : coeficiente de aprendizaje.
		g: funcion de activación.
		gDerivada : funcion de activación derivada.

		retorna : una cell que adentro tiene las matrices de conexiones.


Pasos para usar la red neuronal :

1) asignar a dos variables la función de activación y su derivada.
EJ:
	a = @activation
	b = @activationD

2) Ejecutar mperceptron y guardarte en una variable lo que devuelve:
	EJ : w = mperceptron(1,1,10,1000,0.1,a,b).
3) Para poder compararlo ejecutar pltoComparation:
	EJ : plotComparation(w,a)

