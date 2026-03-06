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

    public Billing generateBill(int reservationId) throws Exception {

        Reservation reservation =
                reservationDAO.findByIdWithDetails(reservationId);

        if (reservation == null)
            throw new IllegalArgumentException("Reservation not found");

        int nights =
                (int) ChronoUnit.DAYS.between(
                        reservation.getCheckIn(),
                        reservation.getCheckOut());

        BigDecimal rate =
                reservation.getRatePerNight();

        BigDecimal total =
                rate.multiply(BigDecimal.valueOf(nights));

        Billing bill =
                new Billing(reservationId, nights, rate, total);

        billingDAO.insert(bill);

        return bill;
    }
}