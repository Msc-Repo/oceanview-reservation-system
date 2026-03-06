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

        Reservation reservation =
                reservationDAO.findByIdWithDetails(reservationId);

        if (reservation == null)
            throw new IllegalArgumentException("Reservation not found");

        int nights =
                (int) ChronoUnit.DAYS.between(
                        reservation.getCheckIn(),
                        reservation.getCheckOut());

        BigDecimal rate = reservation.getRatePerNight();

        BigDecimal subtotal =
                rate.multiply(BigDecimal.valueOf(nights));

        BigDecimal serviceCharge =
                subtotal.multiply(BigDecimal.valueOf(0.10));

        BigDecimal tax =
                subtotal.add(serviceCharge)
                        .multiply(BigDecimal.valueOf(0.15));

        BigDecimal total =
                subtotal.add(serviceCharge).add(tax);

        Billing bill = new Billing();

        bill.setReservationId(reservationId);
        bill.setNights(nights);
        bill.setRatePerNight(rate);
        bill.setServiceCharge(serviceCharge);
        bill.setTaxAmount(tax);
        bill.setTotalAmount(total);

        return bill;
    }

    public void payBill(int reservationId, String paymentMethod) throws Exception {

        Billing bill = generatePreview(reservationId);

        bill.setPaymentMethod(paymentMethod);
        bill.setPaymentStatus("PAID");

        billingDAO.insert(bill);

        reservationDAO.updateStatus(reservationId, "PAID");

        EmailService.sendBillReceipt(bill);
    }


}