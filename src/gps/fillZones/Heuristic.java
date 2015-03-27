package gps.fillZones;

import gps.api.GPSState;

public interface Heuristic {
	
	public int getHValue(FillZoneState state);
	
}
