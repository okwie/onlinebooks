package com.booksonline.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.booksonline.model.Books;
import com.booksonline.model.Cart;
import com.booksonline.model.User;
import com.booksonline.repository.CartRepository;
import com.booksonline.repository.UserRepository;
import com.booksonline.services.Services;
import com.booksonline.web.util.DataValidation;
import com.booksonline.web.util.HandleFiles;

@Controller
@SessionAttributes(value={"loggedInUser", "cart"})
public class UserController {
		
	    @Autowired
		DataValidation dataValidator;
		@Autowired
		Services service;
		@Autowired
		CartRepository cartRepository;
		//connects to database, enabling to save and search user in database
		@Autowired
		UserRepository userRepository;
		
		@Autowired
		HandleFiles handleFiles;
		
		//initializing the user object to save and initialize a new book for editing
		@ModelAttribute("addUser")
		User user() {
			return new User();
		}
		
		@GetMapping("/login")
		String login(Model model) {
			model.addAttribute("msg", "Login");
			return "login";
		}
		
		@GetMapping("/logout")
		public String logout(RedirectAttributes redirect, Model model, WebRequest request, SessionStatus status) {
			status.setComplete();
			request.removeAttribute("loggedInUser", WebRequest.SCOPE_SESSION);
			redirect.addFlashAttribute("out", "You are logged out!");
			return "redirect:/login";
		}
		
		
		@PostMapping("saveUser")
		String saveUser(@ModelAttribute User user, RedirectAttributes redirect, BindingResult result, Model model) throws IllegalArgumentException {
			try {
				
				if(userRepository.findByEmail(user.getEmail())== null) {
				user.setRole("USER");
				userRepository.save(user);
				String msg="Thank you " + user.getFirstName()+ " for registering with us! TxtBook.com";
				model.addAttribute("loggedInUser", user);
				redirect.addFlashAttribute("msg","Thank you, " + user.getFirstName() + " for registering!");
				handleFiles.sendMail(user.getEmail(), msg, "Registration Success!");
				}
				else {
					redirect.addFlashAttribute("error","Email is invalid or exists in the system.");
					return "redirect:/register";
				}
			} catch (IllegalArgumentException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return "redirect:/index";
		}

		@PostMapping("/sign-in")
		String signIn(@ModelAttribute User user, HttpSession session, RedirectAttributes redirect, Model model) {
			
			try {
				
				if(service.authenticate(user.getEmail(), user.getPassword())) {
				
				redirect.addFlashAttribute("loggedInUser", userRepository.findByEmail(user.getEmail()));
				redirect.addFlashAttribute("msg", "Welcome Back!!");
				//find cart
				System.out.println("######" + userRepository.findByEmail(user.getEmail()));
				ArrayList<Cart> mycart=(ArrayList<Cart>) cartRepository.findMyCart(session.getId());
				//if cart is not empty add it to session 
				if(!mycart.isEmpty()) {
					service.updateShopper(user.getEmail(), session.getId());
				}
					redirect.addFlashAttribute("cart", cartRepository.findMyCart(user.getEmail()));
				}	
				else {
					model.addAttribute("msg", "Login");
					model.addAttribute("error", "Username or password incorrect");
					return "login";
				}
			} catch (Exception e) {
				model.addAttribute("msg", "Login");
				model.addAttribute("error", "Username or password incorrect");
				e.printStackTrace();
				return "login";
			}
			
			
			return "redirect:/index";
		}
		
		@GetMapping("register")
		String checkout(Model model) {
			try {
				model.addAttribute("msg", "Register");
				model.addAttribute("action", "saveUser");
				model.addAttribute("user", new User());
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
				return "register";
		}
		@PostMapping("/editrole")
		String userRole(@ModelAttribute User user, RedirectAttributes redirect, Model model) {
			try {
				 service.updateRole(user);
				 redirect.addFlashAttribute("msg", "Role changed");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
				return "redirect:/admin";
		}
		@GetMapping("/admin")
		String admin(Model model) {
			try {
				model.addAttribute("list", userRepository.findAll());
				model.addAttribute("msg", "Welcome Admin");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return "admin";
		}
		@GetMapping("/deleteuser")
		String deleteUser(@RequestParam long id,RedirectAttributes redirect, Model model) {
			try {
				userRepository.deleteById(id);
				redirect.addFlashAttribute("list", userRepository.findAll());
				model.addAttribute("msg", "User Deleted");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return "redirect:/admin";
		}
		@GetMapping("editUser-{id}")
		String editUser(@PathVariable long id, Model model) {
			try {
//				if(!user.getEmail().isEmpty()) {
				model.addAttribute("user", userRepository.findById(id));
				model.addAttribute("hideit", "none");
				model.addAttribute("action", "updateuser");
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
				return "register";
		}
		@PostMapping("updateuser")
		String updateUser(@ModelAttribute User user, RedirectAttributes redirect, Model model) {
			try {
				User u=userRepository.findById(user.getId()).get();
				if(u != null) {
					
					u.setFirstName(user.getFirstName());
					u.setLastName(user.getLastName());
					u.setPhone(user.getPhone());
					userRepository.save(u);
					redirect.addFlashAttribute("msg","Updated ");
					
					}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return "redirect:/profile";
		}
		@PostMapping("contactseller")
		public String contactSeller(@RequestParam String email, @RequestParam String email2, @RequestParam String msg, Model model){
			
			handleFiles.sendMail(email, msg, "Someone contacted you about a book!");
			handleFiles.sendMail(email2, msg, "Thanks for making an inquiry. The seller should respond shortly!");
			
			return "redirect:/index";
			
		}
		
	
	
}
