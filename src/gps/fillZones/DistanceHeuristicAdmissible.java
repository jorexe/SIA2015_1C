package gps.fillZones;


public class DistanceHeuristicAdmissible implements Heuristic{

	@Override
	public int getHValue(FillZoneState state) {
		int minI = getMinimunDistance(state.maxI[0], state.maxI[1], FillZoneState.countRow-1, 0);
		int minJ = getMinimunDistance(state.maxJ[0], state.maxJ[1], 0, FillZoneState.countCol -1);
		int minIJ = getMinimunDistance(state.maxIJ[0], state.maxIJ[1],
									FillZoneState.countRow-1, FillZoneState.countCol -1);
		return Math.max(Math.max(minJ, minI), minIJ);
	}
	
	private int getMinimunDistance(int i, int j, int finalI, int finalJ){
		int distance = finalI - i + finalJ - j;
		int steps = 0;
		while(distance > 0){
			// falta metodo de jorge distance -=
			steps++;
			
		}
		return steps == 0 ? 1:steps;
	}
	

}
