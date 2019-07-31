package com.booksonline.services;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.booksonline.model.Books;
import com.booksonline.model.Cart;
import com.booksonline.model.User;
import com.booksonline.repository.BooksRepository;
import com.booksonline.repository.CartRepository;
import com.booksonline.repository.UserRepository;

@Service
@Transactional
public class Services {
	
	@Autowired
	CartRepository cartRepository;
	@Autowired
	BooksRepository booksRepository;
	@Autowired
	UserRepository userRepository;
	
	public boolean authenticate(String email, String password) {
		
		if(password.equals(userRepository.findByEmail(email).getPassword())) {
			return true;
		}
		else
			return false;
		
	}
	
	public void updateRole(User user) {
		
		User userRole= userRepository.findById(user.getId()).get();
		if(userRole!=null) {
			userRole.setRole(user.getRole());
		}
		
	}
	
	public void deleteFromCart(long id) {
		cartRepository.deleteById(id);
		
	}
	public void deleteFromProfile(long id) {
		booksRepository.deleteById(id);
		
	}
	public List<Books> findAll() {
		return booksRepository.findAll();
		
	}
	public void saveBook(Books book) {
		booksRepository.save(book);
	}
	
	public List<Cart> findMyCart(String email) {
		return cartRepository.findMyCart(email);
		
	}
	
	public void addtocart(long id, String email) {
		Books book=booksRepository.findById(id).get();
		Cart cart=new Cart();
		cart.setAuthor(book.getAuthor());
		cart.setDescription(book.getDescription());
		cart.setImage(book.getImage());
		cart.setTitle(book.getTitle());
		cart.setBookId(id);
		cart.setShopper(email);
		cart.setPrice(book.getPrice());
		cartRepository.save(cart);	
	}
	
	
	public void updateShopper(String email, String session) {
		
		//this does the same thing as the commented out arrraylist thing with the if statement underneath
		//this way uses lamda expressions
		cartRepository.findMyCart(session).forEach(a->a.setShopper(email));
		
//		
//		ArrayList<Cart> mycart=(ArrayList<Cart>) cartRepository.findMyCart(session);
//		if(!mycart.isEmpty()) {
//			mycart.forEach(a->a.setShopper(email));
//		}
	}

}
