package lk.icbt.oceanview.reservation.model;

public class Guest {
    private int id;
    private String fullName;
    private String nicPassport;
    private String phone;
    private String email;

    public Guest() {}

    public Guest(int id, String fullName, String nicPassport, String phone, String email) {
        this.id = id;
        this.fullName = fullName;
        this.nicPassport = nicPassport;
        this.phone = phone;
        this.email = email;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getNicPassport() { return nicPassport; }
    public void setNicPassport(String nicPassport) { this.nicPassport = nicPassport; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
}