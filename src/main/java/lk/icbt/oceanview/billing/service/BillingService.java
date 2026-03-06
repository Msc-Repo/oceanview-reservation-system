package lk.icbt.oceanview.billing.service;

import lk.icbt.oceanview.billing.dao.BillingDAO;
import lk.icbt.oceanview.billing.model.Billing;
import lk.icbt.oceanview.reservation.dao.ReservationDAO;
import lk.icbt.oceanview.reservation.model.Reservation;

import java.math.BigDecimal;
import java.time.temporal.ChronoUnit;

public class BillingService {

    private final BillingDAO billingDAO = new BillingDAO();
    private final ReservationDAO reservationDAO = new ReservationDAO();

    public Billing generatePreview(int reservationId) throws Exception {

        Reservation reservation = reservationDAO.findByIdWithDetails(reservationId);

        if (reservation == null) {
            throw new IllegalArgumentException("No reservation found.");
        }

        // Check if bill already exists
        Billing existingBill = billingDAO.findByReservationId(reservationId);

        if (existingBill != null) {
            existingBill.setGuestName(reservation.getGuestName());
            existingBill.setRoomNumber(reservation.getRoomNumber());
            existingBill.setRoomTypeName(reservation.getRoomTypeName());
            existingBill.setCheckIn(reservation.getCheckIn());
            existingBill.setCheckOut(reservation.getCheckOut());

            java.math.BigDecimal subtotal =
                    existingBill.getRatePerNight().multiply(java.math.BigDecimal.valueOf(existingBill.getNights()));
            existingBill.setSubtotal(subtotal);

            return existingBill;
        }

        int nights = (int) java.time.temporal.ChronoUnit.DAYS.between(
                reservation.getCheckIn(),
                reservation.getCheckOut()
        );

        if (nights <= 0) {
            throw new IllegalArgumentException("Invalid stay duration.");
        }

        java.math.BigDecimal rate = reservation.getRatePerNight();
        java.math.BigDecimal subtotal = rate.multiply(java.math.BigDecimal.valueOf(nights));
        java.math.BigDecimal serviceCharge = subtotal.multiply(java.math.BigDecimal.valueOf(0.10));
        java.math.BigDecimal taxAmount = subtotal.add(serviceCharge)
                .multiply(java.math.BigDecimal.valueOf(0.15));
        java.math.BigDecimal totalAmount = subtotal.add(serviceCharge).add(taxAmount);

        Billing bill = new Billing();
        bill.setReservationId(reservationId);
        bill.setGuestName(reservation.getGuestName());
        bill.setRoomNumber(reservation.getRoomNumber());
        bill.setRoomTypeName(reservation.getRoomTypeName());
        bill.setCheckIn(reservation.getCheckIn());
        bill.setCheckOut(reservation.getCheckOut());
        bill.setNights(nights);
        bill.setRatePerNight(rate);
        bill.setSubtotal(subtotal);
        bill.setServiceCharge(serviceCharge);
        bill.setTaxAmount(taxAmount);
        bill.setTotalAmount(totalAmount);
        bill.setPaymentStatus("UNPAID");

        return bill;
    }

    public void payBill(int reservationId, String paymentMethod) throws Exception {

        if (paymentMethod == null || paymentMethod.isBlank()) {
            throw new IllegalArgumentException("Payment method is required.");
        }

        Billing bill = generatePreview(reservationId);

        bill.setPaymentMethod(paymentMethod);
        bill.setPaymentStatus("PAID");

        billingDAO.insert(bill);

        reservationDAO.updateStatus(reservationId, "PAID");

        EmailService.sendBillReceipt(bill);
    }


}