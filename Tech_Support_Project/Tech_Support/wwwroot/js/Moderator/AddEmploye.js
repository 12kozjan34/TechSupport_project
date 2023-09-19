$(document).ready(function () {
    console.log("AddEmploye.js loaded");

    $('#employeeSelect').change(function () {
        var selectedValue = $('#employeeSelect').val();
        $('#selectedItem').val(selectedValue);
        console.log(selectedValue);
    });

    $('.submitBtn').click(function (e) {
        e.preventDefault(); // Prevent the default form submission

        console.log("Submit button clicked")

        var selectedValue = $('#selectedItem').val();

        console.log(selectedValue);

        if (selectedValue == 0) {
            alert("Please select a user");
            return;
        }

        $.ajax({
            url: '/Moderator/AddEmploye',
            type: 'POST',
            data: { selectedItem: selectedValue },
            success: function (result) {
                console.log(result);
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log("Error:", errorThrown);
                console.log("Status:", textStatus);
            }
        });
    });
});