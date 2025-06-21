package com.example.Shopping.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.Shopping.dao.CommentDAO;
import com.example.Shopping.model.Comment;

@Service
public class CommentService {

    @Autowired
    private final CommentDAO commentDAO;
     

    public CommentService(CommentDAO commentDAO) {
		super();
		this.commentDAO = commentDAO;
	}



	public void addComment(Comment comment) {
        commentDAO.addComment(comment);
    }
}
