function graphNeuronTest(neuronsstart,neuronsend,iterations,extra)
	for i=neuronsstart:neuronsend
		printf("Resolviendo para %d neuronas",num2str(i));
		w = mperceptron(1,1,i,iterations,0.1,@activation,@activationD,0,0,0,0,0.9);
		clf('reset');
		plotComparation(w,@activation);
		name = ["graphs/neu" num2str(i) "it" num2str(iterations) extra ".jpg"];
		%print -djpg name;
		eval(["print -djpg " name]);
		%print(name,"jpg");
	end
end