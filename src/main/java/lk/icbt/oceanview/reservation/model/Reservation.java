package lk.icbt.oceanview.reservation.model;

import java.time.LocalDate;

public class Reservation {
    private int id;
    private int guestId;
    private int roomId;
    private LocalDate checkIn;
    private LocalDate checkOut;
    private int guestsCount;
    private String status;

    // Joined display fields (for list UI)
    private String guestName;
    private String roomNumber;
    private String roomTypeName;
    private int roomTypeId;

    public Reservation() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getGuestId() { return guestId; }
    public void setGuestId(int guestId) { this.guestId = guestId; }

    public int getRoomId() { return roomId; }
    public void setRoomId(int roomId) { this.roomId = roomId; }

    public LocalDate getCheckIn() { return checkIn; }
    public void setCheckIn(LocalDate checkIn) { this.checkIn = checkIn; }

    public LocalDate getCheckOut() { return checkOut; }
    public void setCheckOut(LocalDate checkOut) { this.checkOut = checkOut; }

    public int getGuestsCount() { return guestsCount; }
    public void setGuestsCount(int guestsCount) { this.guestsCount = guestsCount; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getGuestName() { return guestName; }
    public void setGuestName(String guestName) { this.guestName = guestName; }

    public String getRoomNumber() { return roomNumber; }
    public void setRoomNumber(String roomNumber) { this.roomNumber = roomNumber; }

    public String getRoomTypeName() { return roomTypeName; }
    public void setRoomTypeName(String roomTypeName) { this.roomTypeName = roomTypeName; }

    public int getRoomTypeId() { return roomTypeId; }
    public void setRoomTypeId(int roomTypeId) { this.roomTypeId = roomTypeId; }
}