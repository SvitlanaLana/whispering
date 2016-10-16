$("#message_form").submit(function(e){
    var form = $(this);
    var pass = form.find('#message_password').val().trim();
    if(isPassValid(pass)){
        //pass = preparePassword(pass);
        var text = form.find('#message_text').val();
        var encrypted_text = encrypt(text, pass);
        form.find('#hidden_text').val(encrypted_text);
    } else {
        showWrongPass();
        e.preventDefault();
        return false;
    }
});
$("#copy_button").click(function(e){
    var url = $('#new_message_url').attr('href');;
    copyTextToClipboard(url);
});

function copyTextToClipboard(text) {
    var textArea = document.createElement("textarea");

    // Place in top-left corner of screen regardless of scroll position.
    textArea.style.position = 'fixed';
    textArea.style.top = 0;
    textArea.style.left = 0;

    // Ensure it has a small width and height. Setting to 1px / 1em
    // doesn't work as this gives a negative w/h on some browsers.
    textArea.style.width = '2em';
    textArea.style.height = '2em';

    // We don't need padding, reducing the size if it does flash render.
    textArea.style.padding = 0;

    // Clean up any borders.
    textArea.style.border = 'none';
    textArea.style.outline = 'none';
    textArea.style.boxShadow = 'none';

    // Avoid flash of white box if rendered for any reason.
    textArea.style.background = 'transparent';


    textArea.value = text;

    document.body.appendChild(textArea);

    textArea.select();

    try {
        var successful = document.execCommand('copy');
        if(!successful)
            copyToClipboardViaPrompt(text);
    } catch (err) {
        copyToClipboardViaPrompt(text);
    }

    document.body.removeChild(textArea);
}

function copyToClipboardViaPrompt(text) {
    window.prompt("Copy to clipboard: Ctrl+C, Enter", text);
}

function showWrongPass(){
    $('#wrong_pass_tip').removeClass('hide');
}

function isPassValid(text){
    return text.length > 0 && text.length < 17;
}
function preparePassword(pass){
    return pad(Array(17).join(' '), pass, false);
}
