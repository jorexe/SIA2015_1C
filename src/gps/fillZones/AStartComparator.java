package gps.fillZones;

import gps.GPSNode;

import java.util.Comparator;

public class AStartComparator implements Comparator<GPSNode>{

	@Override
	public int compare(GPSNode o1, GPSNode o2) {
		return (Integer.valueOf(o1.getHValue() + o1.getCost()).compareTo(o2.getHValue() + o2.getCost()));
	}
}