package gps.fillZones;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import gps.api.GPSProblem;
import gps.api.GPSRule;
import gps.api.GPSState;

public class FillZoneProblem implements GPSProblem{

	private Heuristic heuristic;
	
	byte[][] board = {{1,3,2,2,6,5,1,1,5,5,6,1,5,2},{2,6,4,4,5,4,4,6,4,4,3,2,5,5},{2,1,6,5,1,6,2,2,6,4,3,3,1,1},{2,5,2,6,2,4,3,2,5,1,3,3,4,5},{3,4,1,2,2,1,4,4,1,4,3,1,4,2},{4,4,6,2,5,4,3,5,3,1,6,3,4,1},{4,4,1,2,5,2,3,3,1,3,6,1,3,2},{5,5,4,3,2,3,3,6,4,2,6,5,4,6},{4,3,5,5,2,4,4,4,6,4,2,4,6,3},{2,1,5,5,2,1,5,4,5,6,3,5,1,3},{4,3,3,6,6,1,2,4,3,2,3,5,2,2},{5,4,5,5,5,3,6,4,6,3,2,6,4,5},{5,3,6,2,2,6,2,3,3,6,5,3,2,6},{4,5,6,1,5,4,5,5,1,5,4,6,4,6}};
	
	public FillZoneProblem(Heuristic heuristic){
		this.heuristic = heuristic;
	}
	public FillZoneProblem() {}
	
	@Override
	public GPSState getInitState() {
		FillZoneState state = new FillZoneState(30);
		Random randomGenerator = new Random();
		for(int i = 0; i<FillZoneState.countRow ; i++){
			for(int j = 0; j< FillZoneState.countCol; j++){
//				state.board[i][j] = (byte) randomGenerator.nextInt(FillZoneState.countColors);
				state.board[i][j] = board[i][j];
			}
		}
		return state;
	}

	@Override
	public GPSState getGoalState() {
		return null;
	}

	@Override
	public List<GPSRule> getRules() {
		List<GPSRule> rules = new ArrayList<GPSRule>();
		for(byte i = 0; i< FillZoneState.countColors ; i++){
			rules.add(new FillZoneRule(i));
		}
		return rules;
	}

	@Override
	public Integer getHValue(GPSState state) {
		return heuristic != null ? heuristic.getHValue((FillZoneState)state) : 0;
	}


}
