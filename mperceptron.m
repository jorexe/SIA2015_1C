function ret = mperceptron(n,lengthOut,hidenN, iterations, rate, g, gDerivada, acceptedError, w, graph)
	% sinh(x)cos(x^2)
	% Si hace falta inicializo los pesos, sino pruebo con los que me pasaron.
	
	% if(w == 0)
		w_1 = rand(n + 1,hidenN);
		w_2 = rand(hidenN+ 1, lengthOut);
	% else
		% w_1 = w{1};
		% w_2 = w{2};	
	% end

	% test = [-2:0.01:2];
	% test = [-1.8 -0.85 0.8 1.8];
	test = [-2:0.001:-1.8 -2:0.01:-1.7 -1.7:0.2:-0.9 -0.9:0.01:-0.75 -0.75:0.2:0.7 0.7:0.01:0.9 0.9:0.2:1.75 1.75:0.01:1.85 1.85:0.01:2]
	% test = [0.5 1];
	expectedOut = [arrayfun(@sinhcos,test)];
	errorAcumulation = 0;
	for i=1:iterations
		randv = randperm(length(test));
		for t=1:length(test)
			%Tomo valores random de mi conjunto de patrones de entrada
			n1 = test(:,randv(t));
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
		      	w_2(:,j) = w_2(:,j) + rate  * delta_2(j) * [-1 inputs_2]';
		    end
		    for j = 1: length(out_1)
		      	w_1(:,j) = w_1(:,j) + rate  * delta_1(j) * [-1 inputs_1]';
		    end
		end
		% Calculamos el error cuadratico medio
		for t=1:length(test)
			inputs_1 = test(:,t);
			expected = expectedOut(:,t);
			out_1 = neuron([-1 inputs_1],w_1,g);
			inputs_2 = arrayfun(g,out_1);
			out_2 = neuron([-1 inputs_2],w_2,g);
			errorAcumulation += (expected - out_2)^2;
		end
		% Promediamos la sumas de los errores y checkeamos si esta en lo aceptado.
		promError = errorAcumulation / t
		if(promError < acceptedError)
			printf ("Corte por aceptación")
			break
		end
		% Voy imprimiendo como mejora el error
		w = {w_1 w_2};
		if(graph == 1)
			if(rem(iterations,100) == 0)
				clf('reset');
				plotComparation(w,g);
				refresh;
			end
		end
		errorAcumulation = 0;
	end
	ret = {w_1 w_2}
end