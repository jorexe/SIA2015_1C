function graphEtaTest(incstart,incend,incstep,decstart,decend,decstep,filename)
	neurons = 5;
	iterations = 100;
	file_id = fopen(filename, 'w+');
	inc = incstart:incstep:incend;
	dec = decstart:decstep:decend;
	totalits = length(inc)*length(dec)*2;
	it = 1;
	for eta=0.05:0.05:0.1
		for i=incstart:incstep:incend
			for j=decstart:decstep:decend
				printf("Resolviendo para eta=%f etainc=%f etadec=%f iteraciones=%d. Etapa %d de %d\n",eta,i,j,iterations,it,totalits);
				fflush(stdout);
				w1 = mperceptron(1,1,neurons,100,eta,@activation,@activationD,0,0,0,0,0.9,1,i,j);
				w2 = mperceptron(1,1,neurons,100,eta,@activation,@activationD,0,0,0,0,0.9,1,i,j);
				w3 = mperceptron(1,1,neurons,100,eta,@activation,@activationD,0,0,0,0,0.9,1,i,j);
				w4 = mperceptron(1,1,neurons,100,eta,@activation,@activationD,0,0,0,0,0.9,1,i,j);
				printf("Errores %f %f %f %f\n",w1{3},w2{3},w3{3},w4{3});
				sumerror = [w1{3},w2{3},w3{3},w4{3}];
				avgerror = mean(sumerror);
				fprintf(file_id,"Para eta=%f etainc=%f etadec=%f iteraciones=%d el error es=%f.\n",eta,i,j,iterations,avgerror);
				fflush(file_id);
				it++;
			end
		end
	end
	fclose(file_id);
end
%EJ: graphEtaTest(0.01,0.1,0.01,0.1,0.5,0.1,"data.txt")