package com.example.Shopping.controller;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.TimeZone;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class VNPayQueryController {

    private static final String VNP_TMN_CODE = "1357K8CQ";
    private static final String VNP_HASH_SECRET = "0738AR9NO3K83VGGESAAN0ZD0HX0F8L1";
    private static final String VNP_API_URL = "https://sandbox.vnpayment.vn/merchant_webapi/api/transaction";

    @PostMapping("/vnpay-query")
    @ResponseBody
    public String queryTransaction(
            @RequestParam("order_id") String orderId,
            @RequestParam("trans_date") String transDate,
            HttpServletRequest request) {

        try {
            String vnp_RequestId = getRandomNumber(8);
            String vnp_Version = "2.1.0";
            String vnp_Command = "querydr";
            String vnp_TmnCode = VNP_TMN_CODE;
            String vnp_TxnRef = orderId;
            String vnp_OrderInfo = "Kiem tra ket qua GD OrderId: " + vnp_TxnRef;
            String vnp_IpAddr = getIpAddress(request);

            Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
            SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
            String vnp_CreateDate = formatter.format(cld.getTime());

            JsonObject vnp_Params = new JsonObject();
            vnp_Params.addProperty("vnp_RequestId", vnp_RequestId);
            vnp_Params.addProperty("vnp_Version", vnp_Version);
            vnp_Params.addProperty("vnp_Command", vnp_Command);
            vnp_Params.addProperty("vnp_TmnCode", vnp_TmnCode);
            vnp_Params.addProperty("vnp_TxnRef", vnp_TxnRef);
            vnp_Params.addProperty("vnp_OrderInfo", vnp_OrderInfo);
            vnp_Params.addProperty("vnp_TransactionDate", transDate);
            vnp_Params.addProperty("vnp_CreateDate", vnp_CreateDate);
            vnp_Params.addProperty("vnp_IpAddr", vnp_IpAddr);

            String hashData = String.join("|", vnp_RequestId, vnp_Version, vnp_Command, vnp_TmnCode, vnp_TxnRef,
                    transDate, vnp_CreateDate, vnp_IpAddr, vnp_OrderInfo);
            String vnp_SecureHash = hmacSHA512(VNP_HASH_SECRET, hashData);

            vnp_Params.addProperty("vnp_SecureHash", vnp_SecureHash);

            URL url = new URL(VNP_API_URL);
            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("POST");
            con.setRequestProperty("Content-Type", "application/json");
            con.setDoOutput(true);

            DataOutputStream wr = new DataOutputStream(con.getOutputStream());
            wr.writeBytes(vnp_Params.toString());
            wr.flush();
            wr.close();

            int responseCode = con.getResponseCode();
            BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
            StringBuilder response = new StringBuilder();
            String output;
            while ((output = in.readLine()) != null) {
                response.append(output);
            }
            in.close();

            JsonObject result = new Gson().fromJson(response.toString(), JsonObject.class);
            String responseCodeFromVNPay = result.get("vnp_ResponseCode").getAsString();
            JsonObject job = new JsonObject();
            if ("00".equals(responseCodeFromVNPay)) {
                job.addProperty("code", "00");
                job.addProperty("message", "Giao dịch thành công: " + result.get("vnp_TransactionStatus").getAsString());
            } else {
                job.addProperty("code", responseCodeFromVNPay);
                job.addProperty("message", "Giao dịch thất bại hoặc chưa hoàn tất: " + result.get("vnp_Message").getAsString());
            }

            return new Gson().toJson(job);

        } catch (Exception e) {
            JsonObject job = new JsonObject();
            job.addProperty("code", "99");
            job.addProperty("message", "Lỗi khi kiểm tra giao dịch: " + e.getMessage());
            return new Gson().toJson(job);
        }
    }

    private String getRandomNumber(int length) {
        String chars = "0123456789";
        StringBuilder sb = new StringBuilder();
        Random random = new Random();
        for (int i = 0; i < length; i++) {
            sb.append(chars.charAt(random.nextInt(chars.length())));
        }
        return sb.toString();
    }

    private String getIpAddress(HttpServletRequest request) {
        String ipAddress = request.getHeader("X-FORWARDED-FOR");
        if (ipAddress == null || ipAddress.isEmpty()) {
            ipAddress = request.getRemoteAddr();
        }
        return ipAddress;
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
