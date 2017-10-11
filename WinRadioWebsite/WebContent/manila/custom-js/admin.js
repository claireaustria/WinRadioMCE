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

