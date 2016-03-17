<div class="tablePagination">
	<input id="pageNumber" type="number" value="${currentPage}">
	<label> de ${totalPages} paginas.</label> 
	<button onclick="goToPage(pageNumber.value)">Ir</button>
</div>
${HTMLTable}