package com.example.Shopping.service;

import com.example.Shopping.dao.ColorDAO;
import com.example.Shopping.model.Color;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class ColorService {
    private final ColorDAO colorDAO;

    public ColorService(ColorDAO colorDAO) {
        this.colorDAO = colorDAO;
    }

    public List<Color> getAllColors() {
        return colorDAO.getAllColors();
    }

    public List<Color> getColorById(int id) {
        return colorDAO.getColorById(id);
    }

    public void addColor(Color color) {
        colorDAO.addColor(color);
    }

    public void updateColor(Color color) {
        colorDAO.updateColor(color);
    }

    public void deleteColor(int id) {
        colorDAO.deleteColor(id);
    }
}