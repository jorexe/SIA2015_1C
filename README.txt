mperceptron(n,lengthOut,hidenN, iterations, eta, g, gDerivada, acceptedError, w_1, w_2, graph, alpha,etaAdaptation,etainc,etadec):
	PARAMS:
		n : longitud de la entrada, en nuestro caso 1.
		lengthOut : longitud de salida , en nuestro caso 1.
		hidenN: cantidad de neuronas en la capa oculta.
		iterations : cantidad de epocas que quiero.
		rate : coeficiente de aprendizaje.
		g: funcion de activación.
		gDerivada : funcion de activación derivada.
                acceptedError: Error de aceptación, la ejecución finalizará si el error es menor a este valor.
		w_1: Si quiero que empieze con unos pesos especifico w_1
		w_2: idem que w_1 nada mas que van a ser los pesos de capa oculta- output
		Si es 0, elige random.
		graph: 1 si quiero que vaya graficando
		alpha: coeficiente de momentum.
		etaAdaptation: 0 si quiero utilizar el eta adaptative, 0 si no
		etainc: incremento constante del eta
		etadec: decremento geometrico de eta (eta = eta - eta*etadec)
		retorna : una cell que adentro tiene las matrices de conexiones y un array con los errores promedio.

doublemperceptron(n,lengthOut,hidenN,hidenN2, iterations, eta, g, gDerivada, acceptedError, w_1, w_2,w_3 , graph,alpha,etaAdaptation,etainc,etadec) :

	Idem que mperceptron.
	hidenN2: Cantidad de neuronas en la ultima capa
	w_3: matriz de pesos para la ultima capa.

	
Pasos para usar la red neuronal :

1) asignar a dos variables la función de activación y su derivada.
EJ:
	a = @activation
	b = @activationD

2) Ejecutar mperceptron y guardarte en una variable lo que devuelve:
	EJ : w = mperceptron(1,1,10,1000,0.1,a,b,0,0,0,1,0.9,1,0.02,0.1).
3) Para poder compararlo ejecutar pltoComparation:
	EJ : plotComparation(w,a)

Otro EJ: plotComparation(mperceptron(1,1,4,100,0.1,@activation,@activationD,0,0,0,0,0.9,1,0.02,0.1),@activation)