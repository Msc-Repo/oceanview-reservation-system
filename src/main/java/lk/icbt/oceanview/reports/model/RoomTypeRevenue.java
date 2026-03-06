package lk.icbt.oceanview.reports.model;

import java.math.BigDecimal;

public class RoomTypeRevenue {

    private String roomType;
    private BigDecimal totalRevenue;

    public RoomTypeRevenue() {}

    public RoomTypeRevenue(String roomType, BigDecimal totalRevenue) {
        this.roomType = roomType;
        this.totalRevenue = totalRevenue;
    }

    public String getRoomType() {
        return roomType;
    }

    public void setRoomType(String roomType) {
        this.roomType = roomType;
    }

    public BigDecimal getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(BigDecimal totalRevenue) {
        this.totalRevenue = totalRevenue;
    }
}