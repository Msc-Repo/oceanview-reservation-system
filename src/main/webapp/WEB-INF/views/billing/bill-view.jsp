<%
    var bill = (lk.icbt.oceanview.billing.model.Billing)
            request.getAttribute("bill");
%>

<h3>Bill Details</h3>

<% if (bill == null) { %>

<div style="color:red;">
    Unable to generate bill.
</div>

<% } else { %>

<table style="width:400px; border-collapse: collapse;">

    <tr>
        <td>Reservation ID</td>
        <td><%= bill.getReservationId() %></td>
    </tr>

    <tr>
        <td>Nights</td>
        <td><%= bill.getNights() %></td>
    </tr>

    <tr>
        <td>Rate per Night</td>
        <td><%= bill.getRatePerNight() %></td>
    </tr>

    <tr>
        <td>Total Amount</td>
        <td><%= bill.getTotalAmount() %></td>
    </tr>

</table>

<% } %>