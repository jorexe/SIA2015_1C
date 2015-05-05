%% : function description
function ret = neuron (inputs,uc)
	% connections = rand(2*n,n);
	% umbral = rand(1 , n);
	%  uc = [umbral ; connections];
	% inputs = [-1 , n1 , n2];
	out = inputs * uc;
	ret = out;
	% printf("%f\n", out);
end

