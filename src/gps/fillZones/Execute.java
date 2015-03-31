package gps.fillZones;

import gps.SearchStrategy;

public class Execute {

	public static void main(String[] args) {
		// Primer argumento : el algoritmo
		// Segundo argumento : la heuristica.
		// Tercer argumento: la cantidad de filas
		// Cuarto argumento: la cantidad de columnas
		// Quinto argumento: la cantidad de movimientos
		// Sexto argumento: Si grafica los pasos intermedios.
		Arguments arguments = parseArguments(args);
		if(arguments == null){
			return;
		}
		System.out.println("HEURISTICA: " + arguments.heuristic);
		System.out.println("STRATEGY: " + arguments.strategy);
		System.out.println("COLS : " + arguments.cols);
		System.out.println("ROWS : " + arguments.rows);
		System.out.println("Moves Left: " + arguments.moves);
		System.out.println("GRAPH:" + arguments.graphic);
		setArguments(arguments);
		FillZoneEngine engine = new FillZoneEngine();
		engine.engine(new FillZoneProblem(arguments.heuristic),
				arguments.strategy);
	}
	
	public static void setArguments(Arguments arg){
		FillZoneState.countCol = arg.cols;
		FillZoneState.countRow = arg.rows;
		FillZoneProblem.MOVES = arg.moves;
		FillZoneEngine.paint = arg.graphic;
		FillZoneState.color = arg.color;
	}

	public static Arguments parseArguments(String[] args) {
		Arguments arguments = new Arguments();
		if (args.length < 2) {
			System.err.println("Cantidad de argumentos invalida");
			return null;
		} else {
			arguments.strategy = SearchStrategy.valueOf(args[0]);
			arguments.heuristic = HeuristicNames.getHeuristic(args[1]);
			if (args.length >= 3) {
				arguments.rows = Integer.valueOf(args[2]);
			}
			if (args.length >= 4) {
				arguments.cols = Integer.valueOf(args[3]);
			}
			if (args.length >= 5) {
				arguments.moves = Integer.valueOf(args[4]);
			}
			if (args.length >= 6) {
				arguments.graphic = Boolean.valueOf(args[5]);
			}
			if (args.length >= 7) {
				arguments.color = Boolean.valueOf(args[6]);
			}
		}
		return arguments;
	}

	private static class Arguments {
		SearchStrategy strategy = SearchStrategy.DFS;
		Heuristic heuristic;
		int rows = 8;
		int cols = 8;
		int moves = 20;
		boolean graphic = false;
		boolean color = false;
	}

}
