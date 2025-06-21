package com.example.Shopping.service;

import com.example.Shopping.dao.SizeDAO;
import com.example.Shopping.model.Size;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class SizeService {
    private final SizeDAO sizeDAO;

    public SizeService(SizeDAO sizeDAO) {
        this.sizeDAO = sizeDAO;
    }

    public List<Size> getAllSizes() {
        return sizeDAO.getAllSizes();
    }

    public List<Size> getSizeById(int id) {
        return sizeDAO.getSizeById(id);
    }

    public boolean addSize(Size size) {
        return sizeDAO.addSize(size) > 0;
    }

    public boolean updateSize(Size size) {
        return sizeDAO.updateSize(size) > 0;
    }

    public boolean deleteSize(int id) {
        return sizeDAO.deleteSize(id) > 0;
    }
}
