
<script src="../../page/tickerlist.js"></script>
<style scoped></style>
<template>
	<div class="row">
		<table class="table table-striped table-hover">
			<thead>
				<tr>
					<th style="width:10px;">#</th>
					<th>Symbol</th>
				</tr>
			</thead>
			<tbody>
				<template v-for="(row, i) in rows" :key="row">
					<tr>
						<td style="width:10px;">{{ (i + 1) }}</td>
						<td>
							<a target="_blank" style="text-decoration:none;color:#333;" v-bind:href="'https://www.tickertape.in' + row.TickerUrl">{{ row.Symbol }}</a>
						</td>
					</tr>
				</template>
			</tbody>
		</table>
	</div>
</template>
