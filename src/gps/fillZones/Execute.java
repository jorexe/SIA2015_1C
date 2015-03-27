package gps.fillZones;

import gps.SearchStrategy;

public class Execute {

	public static void main(String[] args) {
		//Todo hacer que dependiendo los argumentos cambie la estrategia y la heuristica.
		FillZoneEngine engine = new FillZoneEngine();
		engine.engine(new FillZoneProblem(), SearchStrategy.DFS);
	}

}
