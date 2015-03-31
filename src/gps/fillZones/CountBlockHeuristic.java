package gps.fillZones;

public class CountBlockHeuristic implements Heuristic {

	@Override
	public int getHValue(FillZoneState state) {

		int h = FillZoneState.countCol * FillZoneState.countRow
				- state.blocksPainted;
		return h;
	}

}
