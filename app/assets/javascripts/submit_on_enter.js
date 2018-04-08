// Submits the form if any input registers that the user pressed the "Enter" key (Event 13)
$(document).ready(function () {
    $("input").on('keydown', function(e) {
        var keyCode = e.keyCode || e.which;
        if (keyCode == 13) {
            var source = event.target || event.srcElement;
            var form = source.form;
            form.submit();
        }
    });

});