$(document).on('turbolinks:load', function() {
    $('#nav-media').click((function() {
            $(this).next().slideToggle( "slow" );
        })
    )
});