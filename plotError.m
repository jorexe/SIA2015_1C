function ret = plotError(errors, errors2)

	x = 1:1:length(errors);
	y = 1:1:length(errors2)
	title ("Error cuadratico medio");
	hold on;
	plot(x, errors(x), 'r-')
	plot(y, errors2(y), 'b-')
	xlabel('iteración');
	ylabel('Error cuadratico medio');
	legend({"Error cuadratico medio sin Momentum" " Error cuadratico medio con Momentum"});
	hold off;
end