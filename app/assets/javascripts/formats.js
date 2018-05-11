(function( formats, $, undefined ) {
    var editor = null;

    formats.setup = function () {

        loadEditor();
        var submitEditButton = $("#submit_edit_button");
        // Prevent receiving same click event twice
       submitEditButton.unbind( "click" );

        submitEditButton.click(function (event) {
            event.preventDefault();
            validateInput(event);
        });

        /*editor.getSession().on('change', function() {
            //updateAnnotat();
        });*/
    };

    var readEditorValue = function () {
        $('#json').val(editor.getValue());
    };

  /*  formats.loadEditor = function () {
        var container = $('#jsoneditor');
        // Prevent jsoneditor from loading multiple times on reloading page
        if (!container.has('.jsoneditor').length) {
            editor = new JSONEditor(container.get(0), {mode: 'code'})
        }
        editor.set(window.json);
    };*/

    function loadEditor() {
        //console.log('loadEditor');
        var container = $('#json_editor');
        var jsonField =  $('#json');
        //console.log(window.json);
        //console.log(JSON.stringify(window.json));
        //editor = new JSONEditor(container.get(0), {mode: 'code'});
        editor = ace.edit("json_editor");
        editor.setTheme("ace/theme/monokai");
        editor.getSession().setMode("ace/mode/json");
        //editor.setOption("useWorker", false);
        //editor.set(new JSONEditor(container.get(0), {mode: 'code'}));
        //console.log(jsonField.val(JSON.stringify(editor.get())));
        editor.$blockScrolling = Infinity; // Disables a warning message in ace
        editor.setValue(JSON.stringify((window.json), null, '\t'));//((window.json).value);
        //applyLengthLimit();
    }


    function validateInput(event){

        var title = $('#format_title').val();
        var error = JSON.stringify(editor.session.getAnnotations());

        if(error == '[]' &&( title != '' && title != null)){
            readEditorValue();
            $(event.currentTarget).unbind('click').click();
        }else{
            createErrorMessages(title, error);
        }

    }

    function  createErrorMessages(title, error) {

        if((title == null || title == '')&& error != '[]'){
            $('.help-block')[0].innerHTML = "[Can't be blank]";
            $('.error-header')[0].textContent = "Multiple errors prohibited this format from being updated:";
            makeList(["Title can't be blank!","The Json-Editor contains one or more errors!"])
        }
        else if(error == '[]'){
            $('.help-block')[0].innerHTML = "Can't be blank";
            $('.error-header')[0].textContent = "One error prohibited this format from being updated:";
            makeList(["Title can't be blank!"]);
        }else{
            $('.help-block')[0].innerHTML = "";
            $('.error-header')[0].textContent = "One or more errors prohibited this format from being updated:";
            makeList(["The Json-Editor contains one or more errors!"]);
        }

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