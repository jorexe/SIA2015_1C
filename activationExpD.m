function ret = activationExpD(x)
	ret = 2*0.7*activationExp(1- activationExp(x));
end