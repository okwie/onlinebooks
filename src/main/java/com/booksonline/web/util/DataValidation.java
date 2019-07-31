package com.booksonline.web.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.booksonline.model.User;
import com.booksonline.repository.UserRepository;
import com.booksonline.services.Services;

@Component
public class DataValidation implements Validator {
	
//	@Autowired
//	UserRepository userRepository;
//
//	private Services service;
//	@Autowired
//	public DataValidation(Services service) {
//		this.service=service;
//	}
//	@Override
//	public boolean supports(Class<?> clazz) {
//		// TODO Auto-generated method stub
//		return User.class.isAssignableFrom(clazz);
//	}
//
//	@Override
//	public void validate(Object o, Errors errors) {
//		// TODO Auto-generated method stub
//		User user=(User) o;
//		
//		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "lastName", "NotEmpty");
//		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "firstName", "NotEmpty");
//		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "phone", "NotEmpty");
//		
//		if(user.getEmail().length() <=0 || user.getEmail().length() > 18) {
//			errors.rejectValue("email", "size.user.email");
//		}
//		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "email", "NotEmpty");
//		if (userRepository.findByEmail(user.getEmail())!=null) {
//			errors.rejectValue("email", "size.user.unique");
//		}
//		
//		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "password", "NotEmpty");
//		if (user.getPassword().length() <=1 || user.getPassword().length() >= 16) {
//			errors.rejectValue("password", "size.user.password");
//		}

//	}

}
