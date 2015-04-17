function ret = neuralAnd(n1,n2, iterations, coeff, step)
	if(length (n1) != length (n2))
		ret =  "ERROR"
	else
		n = length([n1 n2]);
		% uc = [[0.9 0.9 0.9];diag([0.5 0.5 0.5],3,3);diag([0.5 0.5 0.5],3,3)];
		uc = rand(7,3)

		% connections = rand(2*n,n);
		% umbral = rand(1 , n);
	 	% uc = [umbral ; connections];
		inputs = [-1 , n1 , n2];

		for i = 1:iterations
			out = neuron(inputs,uc,@step);
			for j = 1: length(out)
		      	delta = (n1 & n2) - out;
		      	uc(:,j) = uc(:,j) + coeff  * delta(j) * inputs'; 
	 		end
		end



		out = neuron(inputs,uc,@step)

	end
end
