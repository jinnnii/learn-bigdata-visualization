package com.board.controller;

import com.board.controller.action.Action;
import com.board.controller.action.BoardListAction;

public class ActionFactory {
	private static ActionFactory instance = new ActionFactory();
	
	private ActionFactory() {
		super(); 
	}
	
	public static ActionFactory getInstance() {
		return instance;
	}
	
	public Action getAction(String command) {
		Action action = null;
		System.out.println("ActionFactory : "+command);
		
		if(command.equals("board_list")) {
			action = new BoardListAction();
		}
		return action;
	}
}
