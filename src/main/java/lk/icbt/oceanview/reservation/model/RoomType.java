package lk.icbt.oceanview.reservation.model;

public class RoomType {
    private int id;
    private String typeName;
    private double ratePerNight;

    public RoomType() {}

    public RoomType(int id, String typeName, double ratePerNight) {
        this.id = id;
        this.typeName = typeName;
        this.ratePerNight = ratePerNight;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTypeName() { return typeName; }
    public void setTypeName(String typeName) { this.typeName = typeName; }

    public double getRatePerNight() { return ratePerNight; }
    public void setRatePerNight(double ratePerNight) { this.ratePerNight = ratePerNight; }
}