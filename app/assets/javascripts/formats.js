(function( formats, $, undefined ) {
    var editor = null;

    formats.setup = function () {
        loadEditor();
        $('.help-block')[0].innerHTML = "";

        var submitEditButton = $("#submit_edit_button");
        submitEditButton.unbind( "click" ); // Prevent receiving same click event twice

        submitEditButton.click(function (event) {
            event.preventDefault();
            validateInput(event);
        });
    };

    var readEditorValue = function () {
        $('#json').val(editor.getValue());
    };

    function loadEditor() {
        editor = ace.edit("json_editor");
        var contents = JSON.stringify((window.json), null, '\t')
        editor.session.setValue(contents);

        editor.setOptions({
                'minLines': 20,
                'maxLines': 30,
                'showPrintMargin': false
            });

        editor.session.setMode("ace/mode/json");
        editor.$blockScrolling = Infinity; // Disables a warning message in ace

    }

    function validateInput(event){
        var title = $('#format_title').val();
        var error = JSON.stringify(editor.session.getAnnotations());

        if (error == '[]' && (title != '' && title != null)) {
            readEditorValue();
            $(event.currentTarget).unbind('click').click();
        } else {
            createErrorMessages(title, error);
        }
    }

    function  createErrorMessages(title, error) {
        var helpBlockText = "";
        var listContents = [];

        if (title === null || title === '') {
            listContents.push("Title can't be blank");
            helpBlockText = "Can't be blank";
        }
        if (error !== '[]') {
            listContents.push("The JSON Editor contains one or more errors");
        }

        $('.error-header')[0].textContent = "Format could not be updated:";
        $('.help-block')[0].innerHTML = helpBlockText;
        makeList(listContents);

        $('#error_explanation').removeAttr('hidden');
    }

    function makeList(array) {
        // Create the list element:
        var list = document.getElementById('error-list');
        $('#error-list').empty();

        for(var i = 0; i < array.length; i++) {
            // Create the list item:
            var item = document.createElement('li');

            // Set its contents:
            item.appendChild(document.createTextNode(array[i]));

            // Add it to the list:
            list.appendChild(item);
        }

        // Finally, return the constructed list:
        return list;
    }

}( window.formats = window.formats || {}, jQuery ));