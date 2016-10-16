$("#message_form").submit(function(e){
    var form = $(this);
    var pass = form.find('#message_password').val().trim();
    if(isPassValid(pass)){
        //pass = preparePassword(pass);
        var text = form.find('#message_text').val();
        var encrypted_text = encrypt(text, pass);
        form.find('#message_text').val(encrypted_text);
    } else {
        showWrongPass();
        e.preventDefault();
        return false;
    }
});
function showWrongPass(){
    $('#wrong_pass_tip').removeClass('hide');
}

function isPassValid(text){
    return text.length > 0 && text.length < 17;
}
function preparePassword(pass){
    return pad(Array(17).join(' '), pass, false);
}
