//var editor = null
var loadEditor = function () {
    console.log('loadEditor');
    var container = $('#jsoneditor');
    // Prevent jsoneditor from loading multiple times on reloading page
    if (!container.has('.jsoneditor').length) {
        editor = new JSONEditor(container.get(0), {mode: 'code'})


    }
    editor.set(window.json);
};
var options = {
    mode: 'code',
    onError: function (err) {
        alert(err.toString());
    },
    onChange: function() {
        try {
            console.log(JSON.stringify(editor.get()));
        }
        catch (err) {
            console.error(err);
        }
    }
};

var readEditorValue = function () {

        $('#json').val(JSON.stringify(editor.get()));
    };
