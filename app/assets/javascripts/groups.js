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

$(".accordion dd").on("click", "a:eq(0)", function (event) {
    var dd_parent = $(this).parent();

    if(dd_parent.hasClass('active'))
      $(".accordion dd div.content:visible").slideToggle("normal");
    else {
      $(".accordion dd div.content:visible").slideToggle("normal");
      $(this).parent().find(".content").slideToggle("normal");
    }

});
