function ret = mperceptron(n,lengthOut,hidenN, iterations, rate, g, gDerivada, acceptedError, w_1, w_2 , graph,alpha)
	% sinh(x)cos(x^2)
	% Si hace falta inicializo los pesos, sino pruebo con los que me pasaron.
	
	if(w_1 == 0)
		w_1 = rand(n + 1,hidenN);
	end
	if(w_2 == 0)
		w_2 = rand(hidenN+ 1, lengthOut);
	end
	previousDeltaW_2 = zeros(hidenN+1,lengthOut);
	previousDeltaW_1 = zeros(n+1,hidenN);


	% inputPattern = [-2:0.01:2];
	% inputPattern = [-1.8 -0.85 0.8 1.8];
	inputPattern = [-2:0.001:-1.8 -2:0.01:-1.7 -1.7:0.2:-1.2 -1.2:0.01:-0.75 -0.75:0.2:0.7 0.7:0.01:0.9 0.9:0.2:1.75 1.75:0.01:1.85 1.85:0.01:2];
	testPattern = [-2 : 0.01 : 2];
	% inputPattern = [0.5 1];
	expectedOut = [arrayfun(@sinhcos,inputPattern)];
	expectedOutTest = [arrayfun(@sinhcos,testPattern)];
	errorAcumulation = 0;
	for i=1:iterations
		randv = randperm(length(inputPattern));
		for t=1:length(inputPattern)
			%Tomo valores random de mi conjunto de patrones de entrada
			n1 = inputPattern(:,randv(t));
			expected = expectedOut(:,randv(t));
			inputs_1 = n1;
			%Propago hacia adelante
			out_1 = neuron([-1 inputs_1],w_1,g);
			inputs_2 = arrayfun(g,out_1);
			out_2 = neuron([-1 inputs_2],w_2,g);
			%Calculo los delta
		    delta_2 = arrayfun(gDerivada,out_2).*(expected - out_2);
		    delta_1 = arrayfun(gDerivada,out_1).*(w_2(2:rows(w_2),:)*delta_2')';
		    % Actualizo los pesos.
		    for j = 1: length(out_2)
		    	delta_w2(:,j) = rate  * delta_2(j) * [-1 inputs_2]';
		      	w_2(:,j) = w_2(:,j) + delta_w2(:,j)+ previousDeltaW_2(:,j)  ;
		    end
		    previousDeltaW_2 = delta_w2;
		    for j = 1: length(out_1)
		    	delta_w1(:,j) = rate  * delta_1(j) * [-1 inputs_1]';
		      	w_1(:,j) = w_1(:,j) + delta_w1(:,j) + previousDeltaW_1(:,j) ;
		    end
		    previousDeltaW_1 = delta_w1;
		end
		% Calculamos el error cuadratico medio
		for t=1:length(testPattern)
			inputs_1 = testPattern(:,t);
			expected = expectedOutTest(:,t);
			out_1 = neuron([-1 inputs_1],w_1,g);
			inputs_2 = arrayfun(g,out_1);
			out_2 = neuron([-1 inputs_2],w_2,g);
			errorAcumulation += (expected - out_2)^2;
		end
		% Promediamos la sumas de los errores y checkeamos si esta en lo aceptado.
		promError = errorAcumulation / t;
		if(promError < acceptedError)
			printf ("Corte por aceptación")
			break
		end
		% Voy imprimiendo la aproximación de la función.
		w = {w_1 w_2};
		if(graph == 1)
				clf('reset');
				plotComparation(w,g);
				refresh;
		end
		errorAcumulation = 0;
	end
	ret = {w_1 w_2}
end