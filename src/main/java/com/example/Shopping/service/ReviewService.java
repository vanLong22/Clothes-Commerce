package com.example.Shopping.service;

import com.example.Shopping.dao.ReviewDAO;
import com.example.Shopping.model.Review;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReviewService {
    private final ReviewDAO reviewDAO;

    public ReviewService(ReviewDAO reviewDAO) {
        this.reviewDAO = reviewDAO;
    }

    public List<Review> getAllReviews() {
        return reviewDAO.getAllReviews();
    }

    public Review getReviewById(int id) {
        return reviewDAO.getReviewById(id);
    }

    public boolean addReview(Review review) {
        return reviewDAO.addReview(review) > 0;
    }

    public boolean updateReview(Review review) {
        return reviewDAO.updateReview(review) > 0;
    }

    public boolean deleteReview(int id) {
        return reviewDAO.deleteReview(id) > 0;
    }
}
