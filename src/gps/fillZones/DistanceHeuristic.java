package gps.fillZones;


public class DistanceHeuristic implements Heuristic {

	@Override
	public int getHValue(FillZoneState state) {
		int minI = getMinimunDistance(state.maxI[0], state.maxI[1],
				FillZoneState.countRow - 1, 0, state);
		int minJ = getMinimunDistance(state.maxJ[0], state.maxJ[1], 0,
				FillZoneState.countCol - 1, state);
		int minIJ = getMinimunDistance(state.maxIJ[0], state.maxIJ[1],
				FillZoneState.countRow - 1, FillZoneState.countCol - 1, state);
		int maxValue = Math.max(Math.max(minJ, minI), minIJ);
		if(maxValue > state.movesLeft){
			return Integer.MAX_VALUE;
		}
		return maxValue;
	}

	private int getMinimunDistance(int i, int j, int finalI, int finalJ, FillZoneState state) {
		int distance = finalI - i + finalJ - j;
		return distance;
	}
}
