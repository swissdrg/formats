// Submits the form if any input registers that the user pressed the "Enter" key (Event 13)
$(document).ready(function () {
    $("input").keypress(function(event) {
        if (event.which == 13) {
            event.preventDefault();
            var source = event.target || event.srcElement;
            var form = source.form;
            form.submit();
        }
    });
});