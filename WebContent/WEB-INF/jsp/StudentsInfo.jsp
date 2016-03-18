<div class="tablePagination">
	<input id="pageNumber" type="number" value="${currentPage}" min="1" max="${pageNumber}">
	<label> de ${totalPages} paginas.</label> 
	<button class="button" onclick="selectPage(pageNumber.value)">Ir</button>
</div>
${HTMLTable}
<style>
	.tablePagination {
		padding-bottom:10px;
		float:right;
	}
	
	#pageNumber {
		width: 65px;
	}
	
	.button {
		padding: 0 15px 0 15px;
	}
</style>