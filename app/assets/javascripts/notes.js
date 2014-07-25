$(document).ready(function () {

    $('#new_note').validate({ // initialize the plugin
        rules: {
            "note[pagenumber]": {
                required: true
            },
            "note[body]": {
                required: true,
            }
        }
    });

});