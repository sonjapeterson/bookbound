// $(document).ready(function () {
// 	$('#findbook').validate({
// 		rules: {
// 			query: {
// 				required: true
// 			}
// 		}
// 	});
// });

$(document).ready(function () {

    $('#findbook').validate({ // initialize the plugin
        rules: {
            query: {
                required: true
            }
        }
    });

    $('#searchusers').validate({ // initialize the plugin
        rules: {
            starts_with: {
                required: true
            }
        }
    });

});