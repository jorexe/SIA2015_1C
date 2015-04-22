function ret = plotComparation( w,g )
	w_1 = w{1};
	w_2 = w{2};

	input = [-2:0.1:2];
	for i=1:length(input)
		out_1 = neuron([-1 input(i)],w_1,g);
		inputs_2 = arrayfun(g,out_1);
		out_2(i) = neuron([-1 inputs_2],w_2,g);
	end
	% plot(input,out_2, '*', sinhcos(input), '-')
	plot(input, out_2, '*')
	hold on
	plot(input, sinhcos(input))
end