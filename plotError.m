function ret = plotError(errors)

	x = 1:1:length(errors);
	title ("Error cuadratico medio");
	plot(x, errors(x), 'r-')
	xlabel('iteración');
	ylabel('Error cuadratico medio');
	legend({"Error cuadratico medio"});
end