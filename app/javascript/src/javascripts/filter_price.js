$(document).on('turbolinks:load', function() {
    var min =  Number($("#min").attr("data-index"));
    var max =  Number($("#max").attr("data-index"));
    var value;

    $('#min_price').change((function() {
        changeMin(this.value);
    }));

    $("#min").change((function () {
        changeMin(this.value);
    }));

    $('#max_price').change((function() {
        changeMax(this.value);
    }));

    $("#max").change((function () {
        changeMax(this.value);
    }));

    function changeMin(val){
        value = Number(val);
        if (value <= max && value >= min) {
            $('#min_price').val(val);
            $('#min').val(val);
            $('#max_price').attr({"min": val});
            $('#max').attr({"min": val});
        }
    }

    function changeMax(val){
        value = Number(val);
        if (value <= max && value >= min) {
            $('#max_price').val(val);
            $('#max').val(val);
            $('#min_price').attr({"max": val});
            $('#min').attr({"max": val});
        }
    }
});
