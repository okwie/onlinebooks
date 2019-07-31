	package com.booksonline.controller;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.booksonline.model.Books;
import com.booksonline.model.Cart;
import com.booksonline.model.User;
import com.booksonline.repository.BooksRepository;
import com.booksonline.repository.CartRepository;
import com.booksonline.services.Services;
import com.booksonline.web.util.HandleFiles;

@SessionAttributes(value={"loggedInUser", "cart"})
//when you see whitelabel message it is because it can't read the package, fixed by this @Controller annotation
@Controller
public class AppController {
	@Autowired
	Services service;
	@Autowired
	BooksRepository booksRepository;
	@Autowired
	HandleFiles handleFiles;
	
	@PostMapping(value="uploadFile")
	public String uploadFile(@ModelAttribute Books book, RedirectAttributes redirect, Model model) throws IOException {
		
		try {
			//save file to file system
			handleFiles.saveImage(book);
			//save details to database
			MultipartFile multipartFile = (MultipartFile) book.getFile();
			Books bk=booksRepository.findById(book.getId()).get();
			bk.setImage(multipartFile.getOriginalFilename());
			booksRepository.save(bk);
			//add flash message on redirect to index page
			redirect.addFlashAttribute("msg", "Upload success " + multipartFile.getOriginalFilename());
		} 
		catch (IllegalStateException e) {
			redirect.addFlashAttribute("msg", "Unexpected Error Occured");
			e.printStackTrace();
		}
		
		
		return "redirect:/profile";
	}
	
	@GetMapping({"/","index"})
	String index(Model model) {
	
			model.addAttribute("list", service.findAll());
			return "index";
	}
	
	@PostMapping("saveBook")
	String saveBook(@ModelAttribute Books book, RedirectAttributes redirect, Model model) {
		try {
			service.saveBook(book);
			model.addAttribute("list", service.findAll());
			redirect.addFlashAttribute("success", book.getTitle() + " added!");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "redirect:/profile";
	}
	//initializing the book object to save and initialize a new book for editing
	@ModelAttribute("addBook")
	Books book() {
		return new Books();
	}
	//this gets us the book
	@GetMapping("editBook-{id}")
	String editBook(@PathVariable long id, Model model) {
		try {
			//get the book object to edit from database and populate in the form
			model.addAttribute("addBook", booksRepository.findById(id));
			//get the list and add to index page
			model.addAttribute("list", service.findAll());
			model.addAttribute("msg", "Update Book");
			//set the action to the editBook mapping(method) to handle the request
			model.addAttribute("action", "editBook");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "redirect:/profile";
	}
	//Database Search!!
	@PostMapping("search")
	String search(@RequestParam String author, Model model) {
		
		//check repository for searchBook method
		model.addAttribute("list", booksRepository.searchBook(author));
		//gives all books with that author
		model.addAttribute("msg", booksRepository.searchBook(author).size() +" " + "Found" );
		return "index";
	}
	@PostMapping("editBook")
	String editBook(@ModelAttribute Books book, RedirectAttributes redirect, Model model) {
		try {
			Books bk = booksRepository.findById(book.getId()).get();
			//gets book from database and update
			bk.setAuthor(book.getAuthor());
			bk.setDescription(book.getDescription());
			bk.setTitle(book.getTitle());
			bk.setPrice(book.getPrice());
			bk.setIsbn(book.getIsbn());
			service.saveBook(bk);
			//redirecting to index
			redirect.addFlashAttribute("success", book.getTitle() + " updated!");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "redirect:/profile";
	}
	@GetMapping("remove-{id}-{image}")
	String removeImage(@PathVariable long id, @PathVariable String image, RedirectAttributes redirect, Model model) {
		try {
			//use id to find the book to set image to null (remove)
			Books book = booksRepository.findById(id).get();
			book.setImage("");
			//save the book with no image (remove)
			service.saveBook(book);
			handleFiles.removefiles(image, id);
			redirect.addFlashAttribute("success", "Successfully Deleted!");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			return "redirect:/profile";
	}
	
	
	@GetMapping("deleteBook-{id}")
	String deleteBook(@PathVariable long id, RedirectAttributes redirect, Model model) {
		try {
			service.deleteFromProfile(id);
			redirect.addFlashAttribute("success", "Successfully Deleted!");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			return "redirect:/profile";
	}
	@GetMapping("checkout-{id}")
	String checkout(@PathVariable long id, Model model) {
		try {
			List<Books> books=service.findAll();
			model.addAttribute("list", books);
			model.addAttribute("book", books.stream().filter(a->a.getId()==id).collect(Collectors.toList()).get(0));
			model.addAttribute("msg", "Check Out <i class='fa fa-shopping-bag'></i>");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			return "checkout";
	}
	@GetMapping("/profile")
	String profile(Model model) {
		try {
			model.addAttribute("list", service.findAll());
			model.addAttribute("msg", "TxtBook: An online bookstore for college textbooks");
			model.addAttribute("action", "saveBook");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "profile";
	}
	
	@GetMapping("mycart")
	String guestCart(HttpSession session, ModelMap model) {
		try {
			model.addAttribute("cart", service.findMyCart(session.getId()));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "cart";
	}
	
	@GetMapping("addtocart-{id}")
	  String guestshopper(@PathVariable long id, Model model, HttpSession session){
			try {
				service.addtocart(id, session.getId());	
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}	
			return "redirect:/mycart";
			}
	@GetMapping("addcart-{id}-{email}")
	  String shopper(@PathVariable long id, @PathVariable String email, Model model){
			try {
				service.addtocart(id, email);
				model.addAttribute("cart", service.findMyCart(email));
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}	
			return "cart";
			}
	
	
	@GetMapping("removefromcart-{id}")
	String guestremove(@PathVariable long id, RedirectAttributes redirect, ModelMap model) {
		try {
			service.deleteFromCart(id);
			redirect.addFlashAttribute("msg", "Item Removed!");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			return "redirect:/mycart";
	}
	@GetMapping("deletefromcart-{id}-{email}")
	String remove(@PathVariable long id, @PathVariable String email, RedirectAttributes redirect, ModelMap model) {
		try {
			service.deleteFromCart(id);
			redirect.addFlashAttribute("msg", "Item Removed!");
			redirect.addFlashAttribute("cart", service.findMyCart(email));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			return "redirect:/shoppingcart";
	}
	@GetMapping("shoppingcart")
	String shoppingcart() {
		return "cart";
	}
	
	@GetMapping("shoppcart")
	String cart(@SessionAttribute("loggedInUser") User user, ModelMap model) {
		try {
			model.addAttribute("cart", service.findMyCart(user.getEmail()));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			return "cart";
	}
	//rest API calls
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@GetMapping("/allusers")
	String getApi(Model model) {
		try {
			String url="http://192.168.1.19:3200/onlinebooks/api/users";
			RestTemplate restTemplate= new RestTemplate();
			
			List<LinkedHashMap> getList=restTemplate.getForObject(url, List.class);
			model.addAttribute("list", getList);
		} catch (RestClientException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "admin";
	}

	
}
