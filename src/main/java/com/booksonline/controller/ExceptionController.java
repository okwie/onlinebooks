package com.booksonline.controller;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ExceptionController implements ErrorController{
	
	@GetMapping("error")
	public String hanlerror(HttpServletRequest request, Model model) {
		Object status=request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
		if(status!=null) {
		Integer statuscode=Integer.valueOf(status.toString());
		if(statuscode==(HttpStatus.NOT_FOUND.value())) {
		  model.addAttribute("error", 404);
		}else if(statuscode.equals(HttpStatus.INTERNAL_SERVER_ERROR.value())){
		model.addAttribute("error", 505); 
		}else if(statuscode.equals(HttpStatus.REQUEST_TIMEOUT.value())){
		model.addAttribute("error", 401); 
		}
		 
		}
		return "error";	
		}

	@Override
	public String getErrorPath() {
		// TODO Auto-generated method stub
		return "error";
	}
	

}
