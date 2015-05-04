function graphNeuronTest(neuronsstart,neuronsend,iterations,extra)
	file_id = fopen(["data/" extra ".txt"], 'a+');
	for i=neuronsstart:neuronsend
		printf("Resolviendo para %d neuronas\n",i);
		fflush(stdout);
		w = mperceptron(1,1,i,iterations,0.1,@activation,@activationD,0,0,0,0,0.9,0,0,0);
		clf('reset');
		plotComparation(w,@activation);
		name = ["graphs/neu" num2str(i) "it" num2str(iterations) extra ".jpg"];
		%print -djpg name;
		eval(["print -djpg " name]);
		fprintf(file_id,"neurons=%d,iterations=%d,error=%f,\n",i,iterations,w{3});
		fflush(file_id);
		%print(name,"jpg");
	end
	fclose(file_id);
end