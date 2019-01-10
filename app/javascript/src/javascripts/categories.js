$(document).on('turbolinks:load', function() {
    $('.list-group-item').click((function() {
            $(this).next().slideToggle( "slow" );
        })
    )
});