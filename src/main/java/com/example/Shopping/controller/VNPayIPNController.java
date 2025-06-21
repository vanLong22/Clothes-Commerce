package com.example.Shopping.controller;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class VNPayIPNController {

    private static final String VNP_HASH_SECRET = "0738AR9NO3K83VGGESAAN0ZD0HX0F8L1";

    @PostMapping("/vnpay-ipn")
    @ResponseBody
    public String handleIPN(HttpServletRequest request) {
        Map<String, String> vnp_Params = new HashMap<>();
        Map<String, String[]> parameterMap = request.getParameterMap();
        for (String key : parameterMap.keySet()) {
            String[] values = parameterMap.get(key);
            if (values != null && values.length > 0) {
                vnp_Params.put(key, values[0]);
            }
        }

        String vnp_SecureHash = vnp_Params.get("vnp_SecureHash");
        vnp_Params.remove("vnp_SecureHash");

        List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
        Collections.sort(fieldNames);
        StringBuilder hashData = new StringBuilder();
        Iterator<String> itr = fieldNames.iterator();
        while (itr.hasNext()) {
            String fieldName = itr.next();
            String fieldValue = vnp_Params.get(fieldName);
            if (fieldValue != null && !fieldValue.isEmpty()) {
                hashData.append(fieldName).append('=').append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII));
                if (itr.hasNext()) {
                    hashData.append('&');
                }
            }
        }

        String calculatedHash = hmacSHA512(VNP_HASH_SECRET, hashData.toString());
        JsonObject response = new JsonObject();

        if (calculatedHash.equalsIgnoreCase(vnp_SecureHash)) {
            String vnp_ResponseCode = vnp_Params.get("vnp_ResponseCode");
            if ("00".equals(vnp_ResponseCode)) {
                // Cập nhật trạng thái đơn hàng trong cơ sở dữ liệu
                String vnp_TxnRef = vnp_Params.get("vnp_TxnRef");
                // TODO: Cập nhật trạng thái đơn hàng với vnp_TxnRef
                response.addProperty("RspCode", "00");
                response.addProperty("Message", "Confirm Success");
            } else {
                response.addProperty("RspCode", "97");
                response.addProperty("Message", "Invalid Transaction");
            }
        } else {
            response.addProperty("RspCode", "97");
            response.addProperty("Message", "Invalid Checksum");
        }

        return new Gson().toJson(response);
    }

    private String hmacSHA512(String key, String data) {
        try {
            Mac mac = Mac.getInstance("HmacSHA512");
            SecretKeySpec secretKey = new SecretKeySpec(key.getBytes(StandardCharsets.UTF_8), "HmacSHA512");
            mac.init(secretKey);
            byte[] hmacData = mac.doFinal(data.getBytes(StandardCharsets.UTF_8));
            StringBuilder sb = new StringBuilder();
            for (byte b : hmacData) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (Exception e) {
            throw new RuntimeException("Failed to calculate HMAC SHA512", e);
        }
    }
}