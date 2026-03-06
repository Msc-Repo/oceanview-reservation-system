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
    private BigDecimal serviceCharge;
    private BigDecimal taxAmount;
    private String paymentMethod;
    private String paymentStatus;
    private String guestName;
    private String roomNumber;
    private String roomTypeName;
    private java.time.LocalDate checkIn;
    private java.time.LocalDate checkOut;
    private java.math.BigDecimal subtotal;

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

    public BigDecimal getServiceCharge() { return serviceCharge; }
    public void setServiceCharge(BigDecimal serviceCharge) { this.serviceCharge = serviceCharge; }

    public BigDecimal getTaxAmount() { return taxAmount; }
    public void setTaxAmount(BigDecimal taxAmount) { this.taxAmount = taxAmount; }

    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }

    public String getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }

    public String getGuestName() { return guestName; }
    public void setGuestName(String guestName) { this.guestName = guestName; }

    public String getRoomNumber() { return roomNumber; }
    public void setRoomNumber(String roomNumber) { this.roomNumber = roomNumber; }

    public String getRoomTypeName() { return roomTypeName; }
    public void setRoomTypeName(String roomTypeName) { this.roomTypeName = roomTypeName; }

    public java.time.LocalDate getCheckIn() { return checkIn; }
    public void setCheckIn(java.time.LocalDate checkIn) { this.checkIn = checkIn; }

    public java.time.LocalDate getCheckOut() { return checkOut; }
    public void setCheckOut(java.time.LocalDate checkOut) { this.checkOut = checkOut; }

    public java.math.BigDecimal getSubtotal() { return subtotal; }
    public void setSubtotal(java.math.BigDecimal subtotal) { this.subtotal = subtotal; }
}