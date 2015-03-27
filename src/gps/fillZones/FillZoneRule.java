package gps.fillZones;

import javax.swing.plaf.basic.BasicInternalFrameTitlePane.MaximizeAction;

import gps.SearchStrategy;
import gps.api.GPSRule;
import gps.api.GPSState;
import gps.exception.NotAppliableException;

public class FillZoneRule implements GPSRule {

	public byte colorToApply;

	public FillZoneRule(byte colorToApply) {
		this.colorToApply = colorToApply;
	}

	@Override
	public Integer getCost() {
		return 1;
	}

	@Override
	public String getName() {
		return "Aplique el numero de color";
	}

	@Override
	public GPSState evalRule(GPSState state){
		FillZoneState newState = ((FillZoneState)state).copy();
		if(newState.movesLeft == 0 || newState.board[0][0] == colorToApply){
			return null;
		}
		newState.movesLeft--;
		paint(colorToApply, newState.board[0][0], newState, 0, 0);
		return newState;
	}

	// nextColor y prevColor no pueden ser el mismo color, sino se hace una
	// llamada infinita
	private void paint(byte nextColor, byte prevColor, FillZoneState state,
						int i, int j) {
		//Me fijo si los tengo que guardar como puntos mas proximos a las puntas.
		if(i - j > state.maxI[0] - state.maxI[1]){
			state.maxI[0] = i;
			state.maxI[1] = j;
		}
		if(j - i > state.maxJ[1] - state.maxJ[0]){
			state.maxJ[0] = i;
			state.maxJ[1] = j;
		}
		if(i + j > state.maxIJ[0] + state.maxIJ[1]){
			state.maxIJ[0] = i;
			state.maxIJ[1] = j;
		}
		state.board[i][j] = nextColor;
		if (i > 0) {
			if (state.board[i - 1][j] == prevColor) {
				paint(nextColor, prevColor, state, i - 1, j);
			}
		}
		if (j > 0) {
			if (state.board[i][j - 1] == prevColor) {
				paint(nextColor, prevColor, state, i, j - 1);
			}
		}
		if (i < FillZoneState.countRow-1) {
			if (state.board[i + 1][j] == prevColor) {
				paint(nextColor, prevColor, state, i + 1, j);
			}
		}
		if (j < FillZoneState.countCol-1) {
			if (state.board[i][j + 1] == prevColor) {
				paint(nextColor, prevColor, state, i, j + 1);
			}
		}
	}

}
