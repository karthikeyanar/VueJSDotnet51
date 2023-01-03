
<script src="../../page/list.js"></script>
<style scoped></style>
<template>
	<div>
		<div class="row">
			<div class="col-8">
				<div class="float-start me-3" style="width:auto;">
					<button type="button" class="btn btn-success" v-on:click="addNew()">Add</button>
				</div>
				<div class="float-start me-3" style="width:150px;">
					<datepicker placeholder="FromDate" field="fromDate" :root="search"></datepicker>
				</div>
				<div class="float-start me-3 mt-2" style="width:auto;">
					To
				</div>
				<div class="float-start me-3" style="width:150px;">
					<datepicker placeholder="ToDate" field="toDate" :root="search"></datepicker>
				</div>
				<div class="float-start me-3" style="width:300px;">
					<select2 placeholder="Search" :source=searchSymbol :change="load" :root="search" field="symbol" />
				</div>
				<div class="float-start mt-2" style="width:auto;">
					<input type="checkbox" v-model="search.isIgnore" v-on:change="load" />&nbsp;Except
				</div>
			</div>
			<div class="col-4">
				<pagination ref="pagination" :data="search" :page-range="5" :on-change="load"></pagination>
			</div>
		</div>
		<div class="row">
			<div class="col-12">
				<table class="table table-sm table-borderless">
					<tr>
						<td>XIRR:&nbsp;<span>{{formatNumber(xirr)}}%</span></td>
						<td>Total Capital Call:&nbsp;<span>{{formatNumber(totalCapitalCall)}}</span></td>
						<td>Total Dividend Call:&nbsp;<span>{{formatNumber(totalDividendCall)}}</span></td>
						<td>Total Investment Call:&nbsp;<span>{{formatNumber(totalInvestmentCall)}}</span></td>
						<td>Total Options Call:&nbsp;<span>{{formatNumber(totalOptionsCall)}}</span></td>
						<td>Total Debt Call:&nbsp;<span>{{formatNumber(totalDebtCall)}}</span></td>
					</tr>
				</table> 
			</div> 
		</div>
		<div>
			<table class="table table-striped table-hover">
				<thead>
					<tr>
						<th>Symbol</th>
						<th>Date</th>
						<th style="text-align:right;">Shares</th>
						<th style="text-align:right;">Price</th>
						<th>Type</th>
						<th>&nbsp;</th>
					</tr>
				</thead>
				<tbody>
					<template v-for="(row,i) in rows" :key="row">
						<tr v-if="cBool(row.IsEdit)==false">
							<td v-on:click="editRow(row)">{{row.Symbol}}</td>
							<td v-on:click="editRow(row)">{{formatDate(row.RecordDate)}}</td>
							<td v-on:click="editRow(row)" style="text-align:right;">{{formatNumber(row.NumberOfShares)}}</td>
							<td v-on:click="editRow(row)" style="text-align:right;">{{formatNumber(row.SharePrice)}}</td>
							<td v-on:click="editRow(row)">
								<span v-if="row.LotType=='B'">Buy</span><span v-if="row.LotType=='S'">Sell</span><span v-if="row.LotType=='D'">Dividend</span><span v-if="row.LotType=='P'">Price</span>
							</td>
							<td>
								<i class="fa fa-remove" style="cursor:pointer;" v-on:click="deleteRow(row,i)">&nbsp;</i>
							</td>
						</tr>
						<tr v-if="row.IsEdit==true && row.LotType!='B' && row.LotType!='S'">
							<td>
								<select2 placeholder="Symbol" :data="rowData" :source=searchSymbol :root="row" field="Symbol" />
							</td>
							<td>
								<datepicker field="RecordDate" :root="row"></datepicker>
							</td>
							<td style="text-align:right;"><input type="text" class="form-control" v-model="row.NumberOfShares" /></td>
							<td style="text-align:right;"><input type="text" class="form-control" v-model="row.SharePrice" /></td>
							<td>
								<select class="form-control" v-model="row.LotType">
									<option value="P">Price</option>
									<option value="D">Dividend</option>
								</select>
							</td>
							<td>
								<button type="button" v-bind:disabled="row.IsSaving==true" class="btn btn-sm btn-success" v-on:click="save(row)">Save</button>
								<button type="button" class="btn btn-sm btn-danger" v-on:click="cancelRow(row)">Cancel</button>
							</td>
						</tr>
					</template>
				</tbody>
			</table>
		</div>
	</div>
</template>
