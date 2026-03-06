package lk.icbt.oceanview.billing.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class Billing {

    private int billId;
    private int reservationId;
    private int nights;
    private BigDecimal ratePerNight;
    private BigDecimal totalAmount;
    private LocalDateTime createdAt;

    public Billing() {}

    public Billing(int reservationId, int nights,
                   BigDecimal ratePerNight,
                   BigDecimal totalAmount) {
        this.reservationId = reservationId;
        this.nights = nights;
        this.ratePerNight = ratePerNight;
        this.totalAmount = totalAmount;
    }

    public int getBillId() { return billId; }
    public void setBillId(int billId) { this.billId = billId; }

    public int getReservationId() { return reservationId; }
    public void setReservationId(int reservationId) { this.reservationId = reservationId; }

    public int getNights() { return nights; }
    public void setNights(int nights) { this.nights = nights; }

    public BigDecimal getRatePerNight() { return ratePerNight; }
    public void setRatePerNight(BigDecimal ratePerNight) { this.ratePerNight = ratePerNight; }

    public BigDecimal getTotalAmount() { return totalAmount; }
    public void setTotalAmount(BigDecimal totalAmount) { this.totalAmount = totalAmount; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}