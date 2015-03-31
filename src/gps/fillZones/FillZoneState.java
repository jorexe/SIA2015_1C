package gps.fillZones;

import java.util.Arrays;

import gps.api.GPSState;

public class FillZoneState implements GPSState{

	public int movesLeft;
	public static int countRow = 6;
	public static int countCol = 6;
	public static byte countColors = 6;
	public static boolean color = false;
	public int maxI[] = {0,0};
	public int maxJ[] = {0,0};
	public int maxIJ[] = {0,0};
	public byte[][] board = new byte[countRow][countCol];
	public int blocksPainted = 0;
	
	public FillZoneState(int movesLeft){
		this.movesLeft = movesLeft;
	}
	@Override
	public boolean compare(GPSState state) {
		for(int i = 0 ; i< countRow; i++){
			for(int j=0 ; j< countCol; j++){
				if(board[i][j] != ((FillZoneState)state).board[i][j]){
					return false;
				}
			}
		}
		return movesLeft == ((FillZoneState)state).movesLeft;
	}
	
	public FillZoneState copy(){
		FillZoneState state = new FillZoneState(movesLeft);
		for(int i = 0 ; i< countRow; i++){
			for(int j=0 ; j< countCol; j++){
				state.board[i][j] = board[i][j];
			}
		}
		state.maxI = Arrays.copyOf(maxI, maxI.length);
		state.maxJ = Arrays.copyOf(maxJ, maxJ.length);
		state.maxIJ = Arrays.copyOf(maxIJ, maxIJ.length);
		return state;
	}
	
	public String toString(){
		String s = "";
		for(int i = 0 ; i< countRow; i++){
			for(int j=0 ; j< countCol; j++){
				if(color){
				s += (char)27 + "[3" + board[i][j] + ";" + "3" + + board[i][j] + "m" + board[i][j];
					
				}else{
					s +=board[i][j] + " ";
				}
			}
			s += "\n";
		}
		s += "\n -------------------------- \n" + "    " +  "Movimientos Restantes:" + movesLeft;
		return s;
	}

}
