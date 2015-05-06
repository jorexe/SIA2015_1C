function ret = doublemperceptron(n,lengthOut,hidenN,hidenN2, iterations, eta, g, gDerivada, acceptedError, w_1, w_2,w_3 , graph,alpha,etaAdaptation,etainc,etadec)
	% sinh(x)cos(x^2)
	% Si hace falta inicializo los pesos, sino pruebo con los que me pasaron.
	toGraph = 50;
	if(w_1 == 0)
		w_1 = rand(n + 1,hidenN);
	end
	if(w_2 == 0)
		w_2 = rand(hidenN+ 1, hidenN2);
	end
	if(w_3 == 0)
		w_3 = rand(hidenN2+ 1, lengthOut)
	end
	previousDeltaW_3 = zeros(hidenN2+1,lengthOut);
	previousDeltaW_2 = zeros(hidenN+1,hidenN2);
	previousDeltaW_1 = zeros(n+1,hidenN);
	previousW_1 = zeros(n + 1,hidenN);
	previousW_2 = zeros(hidenN+ 1, hidenN2);
	previousW_3 = zeros(hidenN2+ 1, lengthOut);
	etait=0;
	etaincs=0;
	etadecs=0;
	% inputPattern = [-2:0.01:2];
	% inputPattern = [-1.8 -0.85 0.8 1.8];
	inputPattern = [-2:0.001:-1.8 -2:0.01:-1.7 -1.7:0.2:-1.2 -1.2:0.01:-0.75 -0.75:0.2:0.7 0.7:0.01:0.9 0.9:0.2:1.75 1.75:0.01:1.85 1.85:0.01:2];
	% inputPattern = [ -1.9:0.01:-1.7 , -1.1:0.01:0.09 , 0.7:0.1:0.9 1.85:0.01:2 ];
	testPattern = [-2 : 0.01 : 2];
	% inputPattern = [0.5 1];
	expectedOut = [arrayfun(@sinhcos,inputPattern)];
	expectedOutTest = [arrayfun(@sinhcos,testPattern)];
	errorAcumulation = 0;
	%Epocas
	% i = 1;
	for i=1:iterations
		randv = randperm(length(inputPattern));
		%Me guardo los pesos antes de realizar la iteración de los patrones de entrada
		previousW_3 = w_3;
		previousW_2 = w_2;
		previousW_1 = w_1;
		for t=1:length(inputPattern)
			%Tomo valores random de mi conjunto de patrones de entrada
			n1 = inputPattern(:,randv(t));
			expected = expectedOut(:,randv(t));
			inputs_1 = n1;
			%Propago hacia adelante
			out_1 = neuron([-1 inputs_1],w_1);
			inputs_2 = arrayfun(g,out_1);
			out_2 = neuron([-1 inputs_2],w_2);
			inputs_3 = arrayfun(g,out_2);
			out_3 = neuron([-1 inputs_3],w_3);
			%Calculo los delta
		    delta_3 = arrayfun(gDerivada,out_3).*(expected - out_3);
		    delta_2 = arrayfun(gDerivada,out_2).*(w_3(2:rows(w_3),:)*delta_3')';
		    delta_1 = arrayfun(gDerivada,out_1).*(w_2(2:rows(w_2),:)*delta_2')';
		    % Actualizo los pesos. 
		    % Silenciamos el warning momentaneamente porque queremos que se
		    % haga broadcast del .*, esto es multiplicar cada elemento de
		    % delta_1 por [-1 inputs_1]
		    warning ("off", "Octave:broadcast");
		    delta_w1 = eta  * delta_1 .* [-1 inputs_1]';
		    delta_w2 = eta  * delta_2 .* [-1 inputs_2]';
		    delta_w3 = eta  * delta_3 .* [-1 inputs_3]';
		    warning ("on", "Octave:broadcast");
		    w_1 = w_1 + delta_w1 + previousDeltaW_1 * alpha ;
		    previousDeltaW_1 = delta_w1;
		    w_2 = w_2 + delta_w2 + previousDeltaW_2 * alpha ;
		    previousDeltaW_2 = delta_w2;
		    w_3 = w_3 + delta_w3 + previousDeltaW_3 * alpha ;
		    previousDeltaW_3 = delta_w3;
		end
		% Calculamos el error cuadratico medio
		for t=1:length(testPattern)
			inputs_1 = testPattern(:,t);
			expected = expectedOutTest(:,t);
			out_1 = neuron([-1 inputs_1],w_1);
			inputs_2 = arrayfun(g,out_1);
			out_2 = neuron([-1 inputs_2],w_2);
			inputs_3 = arrayfun(g,out_2);
			out_3(t) = neuron([-1 inputs_3],w_3);
			errors(t) = expected - out_3(t);
			errorAcumulation += (expected - out_3(t))^2;

		end
		
		if(graph == 1 )
		% IMPRIMO
			clf('reset');
			hold on
			title ("sinh(x)*cos(x^2)");
			plot(testPattern, out_3, 'r*')
			plot(testPattern, sinhcos(testPattern), 'b-')
			plot(testPattern, errors, 'g-')
			xlabel('x');
			ylabel('f(x)');
			axis([-2 2 -4 4]);
			legend({"Red neuronal", "sinhcos(x^2)", "error" });
			hold off
			refresh;
			toGraph = 50;
		end
		toGraph -= 1;
		% Promediamos la sumas de los errores y checkeamos si esta en lo aceptado.
		if(i > 1)
			prevpromError = promError;
		end
		promError = errorAcumulation / t;
		if(promError < acceptedError)
			printf ("Corte por aceptación")
			break
		end

		%Valido los errores promedio para aproximar el eta
		if(etaAdaptation == 1 && i > 1)
			etait++;
			% printf("promError: %f, prevpromError: %f",promError,prevpromError);
			if(promError > prevpromError)
				%Si el error es mayor que en la iteración anterior, disminiyuo el eta
				%y vuelvo a utilizar los w's anteriores
				promError = prevpromError;
				%Esto no se hace para salir de minimos
				% w_1 = previousW_1;
				% w_2 = previousW_2;
				eta = eta - eta*etadec;
				etadecs++;
				% i--;
			else
				%Aumento el eta proporcionalmente
				eta = eta+etainc;
				etaincs++;
			end
			
		end

		% Voy imprimiendo la aproximación de la función.
		w = {w_1 w_2};
		errorAcumulation = 0;
		% i++;
	end
	% printf("Iteraciones: %d\nIncrementos de eta: %d\nDecrementos de eta: %d\n",etait,etaincs,etadecs);
	ret = {w_1 w_2 promError etaincs etadecs};
end