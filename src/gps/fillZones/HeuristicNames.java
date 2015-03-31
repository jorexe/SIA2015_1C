package gps.fillZones;

public enum HeuristicNames {
	DH, DHA, DHAC, CB;

	public static  Heuristic getHeuristic(String name) {
		HeuristicNames heuristic = valueOf(name);
		switch (heuristic) {
			case DH: {
				return new DistanceHeuristic();
			}
			case DHA: {
				return new DistanceHeuristicAdmissible();
			}
			case DHAC: {
				return new DistanceHeuristicAdmissibleColor();
			}
			case CB: {
				return new CountBlockHeuristic();
			}
		}
		return null;

	}
}
