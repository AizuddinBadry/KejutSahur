// Execute JavaScript on page load
$(function() {
    $('#userPhone, #salesPhone').intlTelInput({
        responsiveDropdown: true,
        autoFormat: true,
        utilsScript: 'assets/intl-phone/libphonenumber/build/utils.js'
    });
    var $form = $('#contactform'),
        $submit = $('#contactform input[type=submit]');

    // Intercept form submission
    $form.on('submit', function(e) {
        // Prevent form submission and repeat clicks
        e.preventDefault();
        $submit.attr('disabled', 'disabled');

        // Submit the form via ajax
        $.ajax({
            url:'/call',
            method:'POST',
            data: $form.serialize()
        }).done(function(data) {
            alert(data.message);
        }).fail(function() {
            alert('Trial accounts may only make calls to verified numbers.');
        }).always(function() {
            $submit.removeAttr('disabled');
        });

    });
});
