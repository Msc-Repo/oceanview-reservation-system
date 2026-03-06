package lk.icbt.oceanview.billing.service;

import lk.icbt.oceanview.billing.model.Billing;

public class EmailService {

    public static void sendBillReceipt(Billing bill) {
        System.out.println("========================================");
        System.out.println("EMAIL RECEIPT SENT (SIMULATED)");
        System.out.println("Reservation ID : " + bill.getReservationId());
        System.out.println("Guest Name     : " + bill.getGuestName());
        System.out.println("Room Number    : " + bill.getRoomNumber());
        System.out.println("Room Type      : " + bill.getRoomTypeName());
        System.out.println("Check-in       : " + bill.getCheckIn());
        System.out.println("Check-out      : " + bill.getCheckOut());
        System.out.println("Nights         : " + bill.getNights());
        System.out.println("Rate/Night     : LKR " + bill.getRatePerNight());
        System.out.println("Subtotal       : LKR " + bill.getSubtotal());
        System.out.println("Service Charge : LKR " + bill.getServiceCharge());
        System.out.println("Tax Amount     : LKR " + bill.getTaxAmount());
        System.out.println("Total Paid     : LKR " + bill.getTotalAmount());
        System.out.println("Payment Method : " + bill.getPaymentMethod());
        System.out.println("Payment Status : " + bill.getPaymentStatus());
        System.out.println("========================================");
    }
}