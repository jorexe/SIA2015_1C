function ret = plotComparation( w,g )
	w_1 = w{1};
	w_2 = w{2};

	input = [10:0.1:14];
	for i=1:length(input)
		out_1 = neuron([-1 input(i)],w_1);
		inputs_2 = arrayfun(g,out_1);
		out_2(i) = neuron([-1 inputs_2],w_2);
		expected = @nacho(input(i));
		errors(i) = expected - out_2(i);
	end
	% plot(input,out_2, '*', @nacho(input), '-')
	hold on
	title ("sinh(x)*cos(x^2)");
	plot(input, out_2, 'r*')
	plot(input, @nacho(input), 'b-')
	plot(input, errors, 'g-')
	xlabel('x');
	ylabel('f(x)');
	% axis([-2 2 -4 4]);
	legend({"Red neuronal", "@nacho(x^2)", "error" });
	hold off
end