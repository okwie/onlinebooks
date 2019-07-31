package com.booksonline.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.booksonline.model.User;

public interface UserRepository extends JpaRepository<User, Long>{

	@Query("FROM User u WHERE u.email= ?1")
	User findByEmail(String email);
	
	@Query("FROM User u WHERE u.email=?1 AND u.password=?2")
	User authenticate(String email, String password);
	
	
}
