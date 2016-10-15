$("#message_form").submit(function(){
   // Let's find the input to check
   var input = $(this).find("#message_text");
   input.val(input.val() + " dude!");
});