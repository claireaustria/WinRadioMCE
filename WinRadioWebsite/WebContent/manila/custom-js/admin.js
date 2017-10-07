/*Admin log-in in initial page*/
$('#btnAdminPwd').click(function(){    
	var selection = $('#inputAdminPwd').val();
	if (selection != 'admin01') {
		alert("Incorrect password.");
	} else {
		window.location.href='manila/admin.jsp';
	}
});


/*Page redirect*/
$('#btnNewUser').click(function(){
   window.location.href='adminNewUser.jsp';
})


/*Display input field based on account type*/

$('#dropdownUserProfiles').on('change',function(){
   var selection = $(this).val();
   switch(selection){
   	   case 'PROFILE003':
       $('#divScreenName').show();
       break;
   }
});