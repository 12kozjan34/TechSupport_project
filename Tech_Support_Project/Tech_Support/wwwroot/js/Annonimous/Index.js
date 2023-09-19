document.addEventListener("DOMContentLoaded", function () {
    console.log("Script loaded");
    var companyDropdown = document.getElementById("companyDropdown");
    var questionsDiv = document.getElementById("questions");

    companyDropdown.addEventListener("change", function () {
        questionsDiv.innerHTML = "";

        var selectedCompanyId = companyDropdown.value;

        if (selectedCompanyId == 0) {
            questionsDiv.innerHTML = "<p>Please select a company</p>";
            return;
        }

        if (selectedCompanyId) {
            fetch("/Annonimous/GetData?companyId=" + selectedCompanyId)
                .then(function (response) {
                    return response.json();
                })
                .then(function (data) {
                    if (data) {
                        for (var i = 0; i < data.length; i++) {
                            var question = data[i];
                            var odgovoreno = question.odgovoreno == true ? "Odgovoreno" : "Nije odgovoreno";

                            questionsDiv.innerHTML += "<p>" + question.naslov + "(" + odgovoreno + ")</p>";
                        }
                    }
                    if (data.length == 0) {
                        questionsDiv.innerHTML = "<p>There are no questions for this company</p>";
                    }
                })
                .catch(function (error) {
                    console.error("Error fetching data:", error);
                });
        }
    });
});