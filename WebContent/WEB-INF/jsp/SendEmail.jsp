<head>
	<script src="/webapps/vtbe-tinymce/tiny_mce/tiny_mce.js?v=9.1.201410.160373-1_11.6.1173427"></script>
	<style>
		.EmailMessage {
			width:100%;
			height:100vh;
		}
	</style>
</head>
<body>
	<textarea id="EmailMessage" >${EmailMessage}</textarea>
	${Response}
<div style="display:none" id="data">
	<span id="EmailsData">${Emails}</span>
	<span id="IdsData">${Ids}</span>
	<span id="NamesData">${Names}</span>
	<span id="StatusData">${Status}</span>
</div>
<script>
	tinymce.init({
	    selector: '#EmailMessage'
	});
</script>

</body>