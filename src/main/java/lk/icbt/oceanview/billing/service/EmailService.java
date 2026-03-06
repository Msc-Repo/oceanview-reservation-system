package lk.icbt.oceanview.billing.service;

import lk.icbt.oceanview.billing.model.Billing;

public class EmailService {

    public static void sendBillReceipt(Billing bill) {
        System.out.println("====================================");
        System.out.println("EMAIL RECEIPT SENT");
        System.out.println("Reservation ID : " + bill.getReservationId());
        System.out.println("Guest Name     : " + bill.getGuestName());
        System.out.println("Total Paid     : LKR " + bill.getTotalAmount());
        System.out.println("Payment Method : " + bill.getPaymentMethod());
        System.out.println("====================================");
    }
}