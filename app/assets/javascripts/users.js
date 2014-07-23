$(document).ready(function () {

    $('.edit_user').validate({ // initialize the plugin
        rules: {
            "user[email]": {
            	required: true,
                email: true
            },

            "user[age]": {
            	range: [5, 100]
            },

            "user[zipcode]": {
            	zipcodeUS: true
            },

            "user[description]": {
            	maxlength: 400
            }

        }
    });
});