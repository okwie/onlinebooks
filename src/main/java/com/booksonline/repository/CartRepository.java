package com.booksonline.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.booksonline.model.Cart;

public interface CartRepository extends JpaRepository<Cart, Long>{
	
	@Query("FROM Cart WHERE shopper=?1")
	List<Cart> findMyCart(String shopperId);

}
