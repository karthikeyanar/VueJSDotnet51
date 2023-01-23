
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
				</div><div class="clearfix"></div>
				<div class="float-start mt-2" style="width:auto;">
					<input type="checkbox" v-model="search.isOptions" v-on:change="load" />&nbsp;Options
				</div>
				<div class="float-start mt-2" style="width:auto;margin-left:25px;">
					<input type="checkbox" v-model="search.isGold" v-on:change="load" />&nbsp;Gold
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
						<td style="white-space:nowrap;">XIRR:&nbsp;<span>{{formatNumber(xirr)}}%</span></td>
						<td style="white-space:nowrap;">Total Capital Call:&nbsp;<span>{{formatNumber(totalCapitalCall)}}</span></td>
						<td style="white-space:nowrap;">Total Gold:&nbsp;<span>{{formatNumber(totalGold)}}</span></td>
						<td style="white-space:nowrap;">Total Investment Call:&nbsp;<span>{{formatNumber(totalInvestmentCall)}}</span></td>
						<td style="white-space:nowrap;">Total Debt Call:&nbsp;<span>{{formatNumber(totalDebtCall)}}</span></td>
					</tr>
					<tr>
						<td style="white-space:nowrap;">Total PL:&nbsp;<span>{{formatNumber(totalPL)}}&nbsp;({{formatPercentage(totalPLPercent)}})</span></td>
						<td style="white-space:nowrap;">Total Unrealized PL:&nbsp;<span>{{formatNumber(totalUnRealizedPL)}}&nbsp;({{formatPercentage(totalUnRealizedPLPercent)}})</span></td>
						<td colspan="3" style="white-space:nowrap;">Current Market Value:&nbsp;<span>{{formatNumber(currentMarketValue)}}</span></td>
					</tr>
				</table> 
			</div> 
		</div>
		<div>
			<ul class="nav nav-pills">
				<li class="nav-item">
					<a class="nav-link" v-bind:class="{'active':isTransaction==false}" v-on:click="isTransaction=false" aria-current="page" href="#">Shares</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" v-bind:class="{'active':isTransaction==true}" href="#" v-on:click="isTransaction=true">Transactions</a>
				</li>
			</ul><br />
			<table v-if="isTransaction==false" class="table table-striped table-hover">
				<thead>
					<tr>
						<th>Symbol</th>
						<th style="text-align:right;">PL</th>
						<th style="text-align:right;">XIRR</th>
						<th style="text-align:right;">Shares</th>
						<th style="text-align:right;">Avg.Price</th>
						<th style="text-align:right;">Current Price</th>
						<th style="text-align:right;">Amount</th>
						<!--<th style="text-align:right;">UnRealizedPL</th>-->
						<th style="text-align:right;">CMV</th>
					</tr>
				</thead>
				<tbody>
					<template v-for="(row,i) in shares" :key="row">
						<tr v-if="cBool(row.IsEdit)==false">
							<td>{{row.Symbol}}</td>
							<td style="text-align:right;">{{formatPercentage(row.UnRealizedPLPercent)}}<!--&nbsp;({{formatNumber(row.UnRealizedPL)}})--></td>
							<td style="text-align:right;">{{formatNumber(row.XIRR)}}</td>
							<td style="text-align:right;">{{formatNumber(row.NumberOfShares)}}</td>
							<td style="text-align:right;">{{formatNumber(row.SharePrice)}}</td>
							<td style="text-align:right;">{{formatNumber(row.CurrentPrice)}}</td>
							<td style="text-align:right;">{{formatNumber(row.Amount)}}</td>
							<!--<td style="text-align:right;">{{formatPercentage(row.PLPercent)}}&nbsp;({{formatNumber(row.PL)}})</td>-->
							<td style="text-align:right;">{{formatNumber(row.CurrentMarketValue)}}</td>
						</tr>
					</template>
				</tbody>
			</table>
			<table v-if="isTransaction==true" class="table table-striped table-hover">
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
