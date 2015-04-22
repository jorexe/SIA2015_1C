function ret = neuralXor(n1,n2, iterations, rate, g, gDerivada)
	if(length (n1) != length (n2))
		ret =  "ERROR"
	else
		n = length(n1);
		% w = [[0.9 0.9 0.9];diag([0.5 0.5 0.5],3,3);diag([0.5 0.5 0.5],3,3)];
		% w = rand(7,3)
		w_1 = rand(2*n + 1,2*n);
		w_2 = rand(2*n + 1, n);
		test1 = [[-1 -1];[1 1];[-1 -1];[1 1];[-1 -1];[-1 1];[1 -1];[1 1]];
		test2 = [[-1 -1];[-1 -1];[-1 1];[1 1];[1 1];[1 1];[1 1];[1 -1]];
		% test1 = [ 1 ; 1 ; -1 ; -1];
		% test2= [1 ; -1 ; 1 ; -1];
		% connections = rand(2*n,n);
		% umbral = rand(1 , n);
	 	% w = [umbral ; connections];
		inputs1 = [-1 , n1 , n2];
		% expecteddelta = zeros(1,n);
		% delta = zeros(1,n) + 1;
		% for i = 1:iterations
		% while(!isequaln(delta,expecteddelta))
		for i=1:iterations
			randv = randperm(length(test1));
			for t=1:length(test1)
				%Tomo valores random de mi conjunto de patrones de entrada
				n1 = test1(randv(t),:);
				n2 = test2(randv(t),:);
				inputs1 = [-1 n1 n2];
				%Propago hacia adelante
				out_1 = neuron(inputs1,w_1,g);
				inputs_2 = arrayfun(g,out_1);
				out_2 = neuron([-1 inputs_2],w_2,g);
				%Calculo los delta
			    delta_2 = arrayfun(gDerivada,inputs_2).*(xor(n1, n2) - out_2);
			    delta_1 = arrayfun(gDerivada,inputs_2).*(w_2(2:rows(w_2)+1,:)*delta_2');
			    % delta_1 = gDerivada(inputs_2) .* w_2(n*) 
			    %delta_1=  g'(hi) .* (w_2(SIN LA PRIMERA FILA DE UMBRAL) * delta_2;
			    %delta_1 = delta_2 * w_2';
			    for j = 1: length(out_2)
			    	% DELTAW = rate*delta*g'(hi) * entrada
			      	w_2(:,j) = w_2(:,j) + rate  * delta_2(j) * [-1 inputs_2]';
			    end
			    for j = 1: length(out_1)
			      	w_1(:,j) = w_1(:,j) + rate  * delta_1(j) * [inputs1]';
			    end
			end
		end
		% pruebas = input("Ingresar cantidad de pruebas");
		% for k=1:pruebas
		% 	inputs1 = input("Ingresar primer input:\n");
		% 	inputs_2 = input("Ingresar segundo input:\n");
		% 	out_1 = neuron([-1 inputs1 inputs_2],w_1,g)
		% 	inputs_2 = out_1;
		% 	out_2 = neuron([-1 inputs_2],w_2,g)
		test1 = [[-1 -1];[-1 1];[1 -1];[1 1];[-1 -1];[-1 1];[1 -1];[1 1];[-1 -1];[-1 1];[1 -1];[1 1];[-1 -1];[-1 1];[1 -1];[1 1]];
		test2 = [[-1 -1];[-1 -1];[-1 -1];[-1 -1];[-1 1];[-1 1];[-1 1];[-1 1];[1 -1];[1 -1];[1 -1];[1 1];[1 1];[1 1];[1 1];[1 -1]];
		% end
		i = 0
		p = 0
		for t=1:length(test1)
				n1 = test1(t,:);
				n2 = test2(t,:);
				inputs1 = [-1 n1 n2];
				out_1 = neuron([inputs1],w_1,g);
				out_2 = neuron([-1 out_1],w_2,g);
				n1
				n2
				out_2
				xor(n1,n2)
		 		if(isequaln(sign(out_2), xor(sign(n1),sign(n2))))
					i = i +1;
				end
				p = p +1;
		end
		i
		p
		i / p
		% end
		% delta
		% expecteddelta




		% out = neuron(inputs,w,@g)

	end
end