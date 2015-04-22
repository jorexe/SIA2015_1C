function ret = mperceptron(input,lengthOut,hidenN, iterations, rate, g, gDerivada)
	% sinh(x)cos(x^2)

	n = length(input);
	w_1 = rand(n + 1,hidenN);
	w_2 = rand(hidenN+ 1, lengthOut);
	

	% test = [-2:0.01:2];
	% test = [-1.8 -0.85 0.8 1.8];
	test = [-2:0.01:-1.7 -1.7:0.2:-0.9 -0.9:0.01:-0.75 -0.75:0.2:0.7 0.7:0.01:0.9 0.9:0.2:1.75 1.75:0.01:1.85 1.85:0.01:2]
	% test = [0.5 1];
	expectedOut = [arrayfun(@sinhcos,test)];
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

		    for j = 1: length(out_2)
		      	w_2(:,j) = w_2(:,j) + rate  * delta_2(j) * [-1 inputs_2]';
		    end
		    for j = 1: length(out_1)
		      	w_1(:,j) = w_1(:,j) + rate  * delta_1(j) * [-1 inputs_1]';
		    end
		end
	end


	
	% i = 0
	% p = 0
	% for t=1:length(test)
	% 		n1 = test(t,:);
	% 		n2 = test2(t,:);
	% 		inputs_1 = [-1 n1 n2];
	% 		out_1 = neuron([inputs_1],w_1,g);
	% 		out_2 = neuron([-1 out_1],w_2,g);
	% 		n1
	% 		n2
	% 		out_2
	% 		xor(n1,n2)
	%  		if(isequaln(sign(out_2), xor(sign(n1),sign(n2))))
	% 			i = i +1;
	% 		end
	% 		p = p +1;
	% end
	% i
	% p
	% i / p
	ret = {w_1 w_2}
	% out_1 = neuron([-1 inputs_1],w_1,g);
	% inputs_2 = arrayfun(g,out_1);
	% out_2 = neuron([-1 inputs_2],w_2,g)
end