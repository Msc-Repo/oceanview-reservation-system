package lk.icbt.oceanview.reservation.model;

public class Room {
    private int id;
    private String roomNumber;
    private int typeId;
    private Integer floor;
    private boolean active;

    public Room() {}

    public Room(int id, String roomNumber, int typeId, Integer floor, boolean active) {
        this.id = id;
        this.roomNumber = roomNumber;
        this.typeId = typeId;
        this.floor = floor;
        this.active = active;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getRoomNumber() { return roomNumber; }
    public void setRoomNumber(String roomNumber) { this.roomNumber = roomNumber; }

    public int getTypeId() { return typeId; }
    public void setTypeId(int typeId) { this.typeId = typeId; }

    public Integer getFloor() { return floor; }
    public void setFloor(Integer floor) { this.floor = floor; }

    public boolean isActive() { return active; }
    public void setActive(boolean active) { this.active = active; }
}