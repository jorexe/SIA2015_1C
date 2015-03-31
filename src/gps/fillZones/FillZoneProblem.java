package gps.fillZones;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import gps.api.GPSProblem;
import gps.api.GPSRule;
import gps.api.GPSState;

public class FillZoneProblem implements GPSProblem {

	private Heuristic heuristic;
	public static int MOVES = 30;

	byte[][] board = { { 1, 3, 2, 2, 0, 5, 1, 1, 5, 5, 0, 1, 5, 2 },
			{ 2, 0, 4, 4, 5, 4, 4, 0, 4, 4, 3, 2, 5, 5 },
			{ 2, 1, 0, 5, 1, 0, 2, 2, 0, 4, 3, 3, 1, 1 },
			{ 2, 5, 2, 0, 2, 4, 3, 2, 5, 1, 3, 3, 4, 5 },
			{ 3, 4, 1, 2, 2, 1, 4, 4, 1, 4, 3, 1, 4, 2 },
			{ 4, 4, 0, 2, 5, 4, 3, 5, 3, 1, 0, 3, 4, 1 },
			{ 4, 4, 1, 2, 5, 2, 3, 3, 1, 3, 0, 1, 3, 2 },
			{ 5, 5, 4, 3, 2, 3, 3, 0, 4, 2, 0, 5, 4, 0 },
			{ 4, 3, 5, 5, 2, 4, 4, 4, 0, 4, 2, 4, 0, 3 },
			{ 2, 1, 5, 5, 2, 1, 5, 4, 5, 0, 3, 5, 1, 3 },
			{ 4, 3, 3, 0, 0, 1, 2, 4, 3, 2, 3, 5, 2, 2 },
			{ 5, 4, 5, 5, 5, 3, 0, 4, 0, 3, 2, 0, 4, 5 },
			{ 5, 3, 0, 2, 2, 0, 2, 3, 3, 0, 5, 3, 2, 0 },
			{ 4, 5, 0, 1, 5, 4, 5, 5, 1, 5, 4, 0, 4, 0 } };
	private List<GPSRule> rules = new ArrayList<GPSRule>();

	public FillZoneProblem(Heuristic heuristic) {
		this.heuristic = heuristic;
	}

	public FillZoneProblem() {
	}

	@Override
	public GPSState getInitState() {
		FillZoneState state = new FillZoneState(MOVES);
		Random randomGenerator = new Random();
		for (int i = 0; i < FillZoneState.countRow; i++) {
			for (int j = 0; j < FillZoneState.countCol; j++) {
				// state.board[i][j] = (byte)
				// randomGenerator.nextInt(FillZoneState.countColors);
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
		if (rules.isEmpty()) {
			for (byte i = 0; i < FillZoneState.countColors; i++) {
				rules.add(new FillZoneRule(i));
			}
		} else {
			List<GPSRule> mixRules = new ArrayList<GPSRule>(30);
			Random randomGenerator = new Random();
			for (int i = 0; i < FillZoneState.countColors && !rules.isEmpty(); i++) {
				mixRules.add(rules.remove(randomGenerator.nextInt(FillZoneState.countColors-i)));
			}
			rules = mixRules;
		}
		return rules;
	}

	@Override
	public Integer getHValue(GPSState state) {
		return heuristic != null ? heuristic.getHValue((FillZoneState) state)
				: 0;
	}

}
