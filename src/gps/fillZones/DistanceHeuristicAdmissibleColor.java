package gps.fillZones;

import java.util.Comparator;
import java.util.HashSet;
import java.util.PriorityQueue;
import java.util.Set;

public class DistanceHeuristicAdmissibleColor implements Heuristic {
	PriorityQueue<Integer> lenghtsList = new PriorityQueue<Integer>(50,
			new Comparator<Integer>() {
		
		@Override
		public int compare(Integer o1, Integer o2) {
			return o2 - o1;
		}
	});

	@Override
	public int getHValue(FillZoneState state) {
		if(lenghtsList.isEmpty()){
			getPathsLenght(state);
		}
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
		if(maxValue < FillZoneState.countColors){
			return colorsLeft(state);
		}
		return maxValue;
	}
	
	private int colorsLeft(FillZoneState state){
		Set<Integer> colors = new HashSet<Integer>();
		for(int i = 0; i < FillZoneState.countCol; i++){
			for(int j = 0 ; j< FillZoneState.countRow; j++){
				colors.add((int) state.board[i][j]);
			}
		}
		return colors.size() - 1;
	}

	private int getMinimunDistance(int i, int j, int finalI, int finalJ, FillZoneState state) {
		PriorityQueue<Integer> colorDistance = new PriorityQueue<Integer>(lenghtsList);
		int distance = finalI - i + finalJ - j;
		int steps = 0;
		while (distance > 0) {
			distance -= colorDistance.poll();
			steps++;
		}
		return steps == 0 ? 1 : steps;
	}

	private void getPathsLenght(FillZoneState state) {
		FillZoneState mystate = state.copy();
		byte[][] myboard = mystate.board;
		for (int i = 0; i < FillZoneState.countRow; i++)
			for (int j = 0; j < FillZoneState.countCol; j++)
				if (myboard[i][j] != -1)
					lenghtsList.add(getPathLenght(myboard, i, j));
	}

	private int getPathLenght(byte[][] myboard, int i, int j) {
		int lenght = 1;
		int color = myboard[i][j];
		myboard[i][j] = -1;
		if (i > 0) {
			if (myboard[i - 1][j] == color) {
				lenght += getPathLenght(myboard, i - 1, j);
			}
		}
		if (j > 0) {
			if (myboard[i][j - 1] == color) {
				lenght += getPathLenght(myboard, i, j - 1);
			}
		}
		if (i < FillZoneState.countRow - 1) {
			if (myboard[i + 1][j] == color) {
				lenght += getPathLenght(myboard, i + 1, j);
			}
		}
		if (j < FillZoneState.countCol - 1) {
			if (myboard[i][j + 1] == color) {
				lenght += getPathLenght(myboard, i, j + 1);
			}
		}
		return lenght;
	}

}
