package lk.icbt.oceanview.billing.service;

import lk.icbt.oceanview.billing.model.Billing;

public class EmailService {

    public static void sendBillReceipt(Billing bill) {

        System.out.println("EMAIL SENT");
        System.out.println("Reservation: " + bill.getReservationId());
        System.out.println("Amount Paid: " + bill.getTotalAmount());

    }
}