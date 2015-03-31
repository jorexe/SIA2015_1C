package gps;

import gps.api.GPSProblem;
import gps.api.GPSRule;
import gps.api.GPSState;
import gps.fillZones.AStartComparator;
import gps.fillZones.GreedyComparator;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.PriorityQueue;
import java.util.Queue;

public abstract class GPSEngine {

	public Queue<GPSNode> open;
	public List<GPSNode> closed = new ArrayList<GPSNode>();
	public PriorityQueue<GPSNode> lastExploded = new PriorityQueue<GPSNode>(200, new GreedyComparator());

	protected GPSProblem problem;

	// Use this variable in the addNode implementation
	private SearchStrategy strategy;
	protected long generatedStates = 0;
	private long explosionCounter = 0;
	
	public void engine(GPSProblem myProblem, SearchStrategy myStrategy) {
		long elapsedTime = System.currentTimeMillis();
		problem = myProblem;
		strategy = myStrategy;

		GPSNode rootNode = new GPSNode(problem.getInitState(), 0);
		boolean finished = false;
		boolean failed = false;
		createList(myStrategy);
		open.add(rootNode);
		while (!failed && !finished) {
			if (open.size() <= 0) {
				failed = true;
			} else {
				GPSNode currentNode = open.poll();
				closed.add(currentNode);
				if (isGoal(currentNode)) {
					finished = true;
					printResult(currentNode);
				} else {
					explosionCounter++;
					explode(currentNode);
				}
			}
		}

		if (finished) {
			System.out.println("OK! solution found!");
		} else if (failed) {
			System.err.println("FAILED! solution not found!");
		}
		System.out.println("Elapsed time: " + (System.currentTimeMillis() - elapsedTime) + "ms");
	}

	public void createList(SearchStrategy strategy) {
		switch (this.getStrategy()) {
			case DFS: {
				open = new AddFirstList<GPSNode>();
				break;
			}
			case BFS: {
				open = new LinkedList<GPSNode>();
				break;
			}
			case ITERATIVE: {
				open = new AddFirstList<GPSNode>();
				break;
			}
			case AStar: {
				open = new PriorityQueue<GPSNode>(200,new AStartComparator());
				break;
			}
			case GREEDY: {
				open = new AddFirstList<GPSNode>();
				break;
			}
			default: {
				open = new AddFirstList<GPSNode>(); // El default es DFS
			}
		}
	}

	public boolean isGoal(GPSNode currentNode) {
		return currentNode.getState() != null
				&& currentNode.getState().compare(problem.getGoalState());
	}

	private boolean explode(GPSNode node) {
		if (problem.getRules() == null) {
			System.err.println("No rules!");
			return false;
		}
		for (GPSRule rule : problem.getRules()) {
			GPSState newState = null;
			newState = rule.evalRule(node.getState());
			if (newState != null
					&& !checkBranch(node, newState)
					&& !checkOpenAndClosed(node.getCost() + rule.getCost(),
							newState)) {
				GPSNode newNode = new GPSNode(newState, node.getCost()
						+ rule.getCost());
				newNode.setParent(node);
				addNode(newNode);
			}
		}
		if(strategy == SearchStrategy.GREEDY){
			while(!lastExploded.isEmpty()){
				open.add(lastExploded.poll());
			}
		}
		return true;
	}

	private boolean checkOpenAndClosed(Integer cost, GPSState state) {
		for (GPSNode openNode : open) {
			if (openNode.getState().compare(state) && openNode.getCost() <= cost) {
				return true;
			}
		}
		for (GPSNode closedNode : closed) {
			if (closedNode.getState().compare(state)
					&& closedNode.getCost() <= cost) {
				return true;
			}
		}
		return false;
	}

	private boolean checkBranch(GPSNode parent, GPSState state) {
		if (parent == null) {
			return false;
		}
		return checkBranch(parent.getParent(), state)
				|| state.compare(parent.getState());
	}

	public SearchStrategy getStrategy() {
		return strategy;
	}
	
	private void printResult(GPSNode node){
		System.out.println(node.getSolution());
		System.out.println("Cost: " + node.getCost());
		System.out.println("Expanded nodes: " + explosionCounter);
		System.out.println("Generated states: " + generatedStates);
		System.out.println("Frontier: " + open.size());
	}

	public abstract void addNode(GPSNode node);

}
