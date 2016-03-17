<div class="tablePagination">
	<input id="pageNumber" type="number" value="${currentPage}" min="1" max="${pageNumber}">
	<label> de ${totalPages} paginas.</label> 
	<button onclick="selectPage(pageNumber.value)">Ir</button>
</div>
${HTMLTable}
<style>
	.tablePagination {
		padding-bottom:10px;
	}
	
	#pageNumber {
		width: 65px;
	}
</style>