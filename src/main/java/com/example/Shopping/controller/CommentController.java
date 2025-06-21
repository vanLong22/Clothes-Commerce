package com.example.Shopping.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.example.Shopping.model.Comment;
import com.example.Shopping.service.CommentService;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/comment")
public class CommentController {

    @Autowired
    private final CommentService commentService;
    
    

    public CommentController(CommentService commentService) {
		super();
		this.commentService = commentService;
	}

    

	@PostMapping("/them")
    public ResponseEntity<Map<String, Object>> addComment(@RequestBody Comment comment) {
        try {
            if (comment.getContent() == null || comment.getContent().trim().isEmpty()) {
                return ResponseEntity.badRequest().body(null);
            }
            
            comment.setCreateAt(new java.sql.Date(new Date().getTime()));
            commentService.addComment(comment);
            
            Map<String, Object> response = new HashMap<>();
            response.put("status", "success");
            response.put("message", "Xóa sản phẩm thành công!");
            
            System.out.println("Thêm bình luận thành công.");
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(null);
        }
    }
}
