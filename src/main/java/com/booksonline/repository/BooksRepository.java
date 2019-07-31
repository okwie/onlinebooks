package com.booksonline.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.booksonline.model.Books;

public interface BooksRepository extends JpaRepository<Books, Long> {
	
	@Query("FROM Books WHERE author= ?1")
	List<Books> searchBook(String author);

}
