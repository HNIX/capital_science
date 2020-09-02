$(document).on("turbolinks:load", function() {
    var selectizeCallback = null;

    $(".list-modal").on("closeModal", function(e) {
        if (selectizeCallback != null) {
            selectizeCallback();
            selectizeCallback = null;
        }

        $("#new_list").trigger("reset");
        $.rails.enableFormElements($($.rails.formSubmitSelector));
    });

    $("#new_list").on("submit", function(e) {
        e.preventDefault();
        $.ajax({
            method: "POST",
            url: $(this).attr("action"),
            data: $(this).serialize(),
            success: function(response) {
                selectizeCallback({value: response.id, text: response.name});
                selectizeCallback = null;

                $(".list-modal").addClass("hidden").trigger("closeModal");
                $("#bg-overlay").addClass("hidden");
            }
        });
    });

    $("#cancel-btn").on("click", function(e) {
        $(".list-modal").addClass("hidden").trigger("closeModal");
        $("#bg-overlay").addClass("hidden");
    });

    $(".selectize").selectize({
        create: function(input, callback) {
            selectizeCallback = callback;

            $("#list_name").val(input);
            $(".list-modal").removeClass("hidden");
            $("#bg-overlay").removeClass("hidden");
        }
    });
});