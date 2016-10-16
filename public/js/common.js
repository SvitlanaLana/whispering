if(typeof(String.prototype.trim) === "undefined")
{
    String.prototype.trim = function()
    {
        return String(this).replace(/^\s+|\s+$/g, '');
    };
}

function pad(pad, str, padLeft) {
    if (typeof str === 'undefined')
        return pad;
    if (padLeft) {
        return (pad + str).slice(-pad.length);
    } else {
        return (str + pad).substring(0, pad.length);
    }
}

function encrypt(text, pass){
    return CryptoJS.AES.encrypt(text, pass).toString();
}

function decrypt(text, pass){
    return CryptoJS.AES.decrypt(text, pass).toString(CryptoJS.enc.Utf8);
}

