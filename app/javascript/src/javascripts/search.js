$(document).on('turbolinks:load', function() {
    $('#search').autocomplete({
        source: function(req, res) {
            var arraySource = $('#search').data('autocomplete-source');
            var results = $.ui.autocomplete.filter(arraySource, req.term);
            res(results.slice(0, 5));
        },
        minLength: 2
    });
});
