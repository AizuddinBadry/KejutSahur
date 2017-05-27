// Execute JavaScript on page load
$(function() {
//testingg
//testingg

//testingg
//testingg
//testingg
//testingg
//testingg
//testingg

    $.ajax({
            url:'/customerlist',
            method:'GET',
        }).success(function(data) {
            var queueIDs = [];
            for(var i=0;i<data.length;i++) {
            queueIDs.push(+data[i]['phone']);
          };
            console.log(queueIDs);
        });

    $('#userPhone, #salesPhone').intlTelInput({
        responsiveDropdown: true,
        autoFormat: true,
        utilsScript: 'assets/intl-phone/libphonenumber/build/utils.js'
    });
    var $customerForm = $('#customerForm'),
        $customerSubmit = $('#customerForm input[type=submit]');

    // Intercept form submission
    $customerForm.on('submit', function(e) {
        // Prevent form submission and repeat clicks
        e.preventDefault();
        $customerSubmit.attr('disabled', 'disabled');

        // Submit the form via ajax
        $.ajax({
            url:'/store',
            method:'POST',
            data: $customerForm.serialize()
        }).success(function(data) {
            console.log(data.message);
        }).done(function(data) {
            alert('Terima kasih! Pihak kami akan kejut anda sahur setiap pagi!');
        }).fail(function() {
            alert('Maaf, anda telah berdaftar bersama kami!');
        }).always(function() {
            $customerSubmit.removeAttr('disabled');
        });
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
            alert('Maaf, kami tidak dapat menghubungi anda!');
        }).always(function() {
            $submit.removeAttr('disabled');
        });

    });
});
