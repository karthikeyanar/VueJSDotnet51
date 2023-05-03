
<script src="../../page/list.js"></script>
<style scoped></style>
<template>
	<div>
		<div class="row">
			<div class="col-8">
				<div class="float-start me-3" style="width:auto;">
					<button type="button" class="btn btn-success" v-on:click="addNew()">Add</button>
				</div>
				<div class="float-start me-3" style="width:120px;">
					<datepicker placeholder="FromDate" field="fromDate" :root="search"></datepicker>
				</div>
				<div class="float-start me-3 mt-2" style="width:auto;">
					To
				</div>
				<div class="float-start me-3" style="width:120px;">
					<datepicker placeholder="ToDate" field="toDate" :root="search"></datepicker>
				</div>
				<div class="float-start me-3" style="width:250px;">
					<select2 placeholder="Search" :source=searchSymbol :change="load" :root="search" field="symbol" />
				</div>
				<div class="float-start mt-2" style="width:auto;">
					<input type="checkbox" v-model="search.isIgnore" v-on:change="load" />&nbsp;Except
				</div>
				<div class="float-start mt-2" style="width:auto;margin-top:4px;margin-left:10px;">
					<select class="form-select form-select-sm" v-model="search.tradeType" v-on:change="load">
						<option value="">Trade Type</option>
						<option value="B">Buy</option>
						<option value="S">Sell</option>
						<option value="P">Price</option>
						<option value="D">Dividend</option>
					</select>
				</div><div class="clearfix">&nbsp;</div><br/>
				<div class="float-start mt-2" style="width:auto;display:none;">
					<input type="checkbox" v-model="search.isOptions" v-on:change="load" />&nbsp;Options
				</div>
				<!--<div class="float-start mt-2" style="width:auto;margin-left:25px;">
					<input type="checkbox" v-model="search.isGold" v-on:change="load" />&nbsp;Gold
				</div>-->
				<div class="float-start mt-2" style="width:auto;margin-left:25px;">
					Amount<input type="number" class="form-control" v-model="allocationAmount" v-on:change="loadAllocation" placeholder="Allocation Amount" />
				</div>
				<div class="float-start mt-2" style="width:auto;margin-left:25px;">
					<input type="checkbox" v-model="isShowAllocation" v-on:change="loadAllocation" />&nbsp;Allocation
				</div><div class="clearfix">&nbsp;</div><br/>
			</div>
			<div class="col-4">
				<pagination ref="pagination" :data="search" :page-range="5" :on-change="load"></pagination>
			</div>
		</div>
		<div class="row" v-if="isShowAllocation==true">
			<table v-if="isTransaction==false" class="table table-striped table-hover">
				<thead>
					<tr>
						<th>Symbol</th>
						<th style="text-align:right;">Total</th>
						<th style="text-align:right;">Price</th>
						<th style="text-align:right;">Require Shares</th>
						<th style="text-align:right;">Current Shares</th>
						<th style="text-align:right;">Balance Shares</th>
						<th style="text-align:right;">Percentage</th>
						<th style="text-align:right;">Balance Amount</th>
					</tr>
				</thead>
				<tbody>
					<template v-for="(row,i) in allocationList" :key="row">
						<tr>
							<td>{{row.Symbol}}</td>
							<td style="text-align:right;">{{formatNumber(row.Total)}}</td>
							<td style="text-align:right;">{{formatNumber(row.Price)}}</td>
							<td style="text-align:right;">{{formatNumber(row.RequireShares)}}</td>
							<td style="text-align:right;">{{formatNumber(row.CurrentShares)}}</td>
							<td style="text-align:right;">{{formatNumber(row.Balance)}}</td>
							<td style="text-align:right;">{{formatPercentage(row.Percentage)}}</td>
							<td style="text-align:right;">{{formatNumber(row.Balance * row.Price)}}</td>
						</tr>
					</template>
				</tbody>
			</table>
		</div>
		<div class="row" v-if="isShowAllocation==false">
			<div class="col-12">
				<table class="table table-sm table-borderless">
					<tr>
						<td style="white-space:nowrap;">XIRR:&nbsp;<span>{{formatNumber(xirr)}}%</span></td>
						<td style="white-space:nowrap;">Investment:&nbsp;<span>{{formatNumber(totalCapitalCall)}}</span></td>
						<td style="white-space:nowrap;">Current Market Value:&nbsp;<span>{{formatNumber(currentMarketValue)}}</span></td>
						<td style="white-space:nowrap;">Profit & Loss:&nbsp;<span>{{formatNumber(totalPL)}}&nbsp;({{formatPercentage(totalPLPercent)}})</span></td>
						<!--<td style="white-space:nowrap;">Gold:&nbsp;<span>{{formatNumber(totalGold)}}</span></td>-->
					</tr>
				</table> 
			</div> 
		</div>
		<div v-if="isShowAllocation==false">
			<ul class="nav nav-pills">
				<li class="nav-item">
					<a class="nav-link" v-bind:class="{'active':isTransaction==false}" v-on:click="isTransaction=false" aria-current="page" href="#">Shares</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" v-bind:class="{'active':isTransaction==true}" href="#" v-on:click="isTransaction=true">Transactions</a>
				</li>
			</ul><br />
			<div v-if="isTransaction==false" style="margin-bottom:10px;">
				<table class="table">
					<tbody>
						<tr>
							<template v-for="(row,i) in indexList">
								<td>{{row.Name}}:&nbsp;{{formatPercentage(row.PLPercent)}}</td>
							</template>
						</tr>
					</tbody>
				</table>
				<div style="float:left;margin-right:5px;margin-top:5px;">Sort By:</div>
				<div style="float:left;margin-right:10px;">
					<select class="form-select form-select-sm" v-model="listSearch.sortName" v-on:change="loadShares">
						<option value="PL">Profit & Loss</option>
						<option value="PLPercent">Profit & Loss %</option>
						<option value="XIRR">XIRR</option>
						<option value="NumberOfShares">Shares</option>
						<option value="SharePrice">Avg.Price</option>
						<option value="CurrentPrice">Current Price</option>
						<option value="Amount">Amount</option>
						<option value="CurrentMarketValue">CMV</option>
					</select>
				</div>
				<div style="float:left;margin-right:5px;margin-top:5px;">Sort Order:</div>
				<div style="float:left;">
					<select class="form-select form-select-sm" v-model="listSearch.sortOrder" v-on:change="loadShares">
						<option value="asc">Asc</option>
						<option value="desc">desc</option>
					</select>
				</div><div class="clearfix"></div>
			</div>
			<table v-if="isTransaction==false" class="table table-striped table-hover">
				<thead>
					<tr>
						<th>Symbol</th>
						<th style="text-align:right;">PL%</th>
						<th style="text-align:right;">PL</th>
						<th style="text-align:right;">Shares</th>
						<th style="text-align:right;">LTCG Shares</th>
						<th style="text-align:right;">Avg.Price</th>
						<th style="text-align:right;">Current Price</th>
						<th style="text-align:right;">Amount</th>
						<th style="text-align:right;">CMV</th>
					</tr>
				</thead>
				<tbody>
					<template v-for="(row,i) in shares" :key="row">
						<tr v-if="cBool(row.IsEdit)==false">
							<td>{{row.Symbol}}</td>
							<td style="text-align:right;">{{formatPercentage(row.PLPercent)}}</td>
							<td style="text-align:right;">{{formatNumber(row.PL)}}</td>
							<td style="text-align:right;">{{formatNumber(row.NumberOfShares)}}</td>
							<td style="text-align:right;">{{formatNumber(row.LTCGShares)}}</td>
							<td style="text-align:right;">{{formatNumber(row.SharePrice)}}</td>
							<td style="text-align:right;">{{formatNumber(row.CurrentPrice)}}</td>
							<td style="text-align:right;">{{formatNumber(row.Amount)}}</td>
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
								<select class="form-select form-select-sm" v-model="row.LotType">
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
