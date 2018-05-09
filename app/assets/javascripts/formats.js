(function( formats, $, undefined ) {
    var editor = null;

    formats.loadEditor = function () {
        var container = $('#jsoneditor');
        // Prevent jsoneditor from loading multiple times on reloading page
        if (!container.has('.jsoneditor').length) {
            editor = new JSONEditor(container.get(0), {mode: 'code'})
        }
        editor.set(window.json);
    };

    formats.readEditorValue = function () {
        $('#json').val(JSON.stringify(editor.get()));
    };
}( window.formats = window.formats || {}, jQuery ));