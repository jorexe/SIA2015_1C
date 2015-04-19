function ret = neuralAnd(n1,n2, iterations, coeff, step)
	if(length (n1) != length (n2))
		ret =  "ERROR"
	else
		n = length(n1);
		% uc = [[0.9 0.9 0.9];diag([0.5 0.5 0.5],3,3);diag([0.5 0.5 0.5],3,3)];
		% uc = rand(7,3)
		uc = rand(2*n + 1,n);

		% connections = rand(2*n,n);
		% umbral = rand(1 , n);
	 	% uc = [umbral ; connections];
		inputs = [-1 , n1 , n2];
		expecteddelta = zeros(1,n);
		delta = zeros(1,n) + 1;
		% for i = 1:iterations
		while(!isequaln(delta,expecteddelta))
			out = neuron(inputs,uc,@step);
			for j = 1: length(out)
		      	delta = (n1 & n2) - out;
		      	uc(:,j) = uc(:,j) + coeff  * delta(j) * inputs';
	 		end
		end
		delta
		expecteddelta




		out = neuron(inputs,uc,@step)

	end
end
