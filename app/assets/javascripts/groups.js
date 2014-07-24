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

$(".accordion dd").on("click", "a:eq(0)", function (event) {
    var dd_parent = $(this).parent();

    if(dd_parent.hasClass('active'))
      $(".accordion dd div.content:visible").slideToggle("normal");
    else {
      $(".accordion dd div.content:visible").slideToggle("normal");
      $(this).parent().find(".content").slideToggle("normal");
    }

});
