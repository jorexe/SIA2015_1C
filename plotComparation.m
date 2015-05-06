function ret = plotComparation( w,g )
	w_1 = w{1};
	w_2 = w{2};

	input = [-2:0.1:2];
	for i=1:length(input)
		out_1 = neuron([-1 input(i)],w_1);
		inputs_2 = arrayfun(g,out_1);
		out_2(i) = neuron([-1 inputs_2],w_2);
		expected = sinhcos(input(i));
		errors(i) = expected - out_2(i);
	end
	% plot(input,out_2, '*', sinhcos(input), '-')
	hold on
	title ("sinh(x)*cos(x^2)");
	plot(input, out_2, 'r*')
	plot(input, sinhcos(input), 'b-')
	plot(input, errors, 'g-')
	xlabel('x');
	ylabel('f(x)');
	axis([-2 2 -4 4]);
	legend({"Red neuronal", "sinhcos(x^2)", "error" });
	hold off
end