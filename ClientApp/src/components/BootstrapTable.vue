<template> 
<div>
        <div>
            <template v-if="$slots['top_page_options']">
            <div class="col-auto me-auto">
                <slot name="top_page_options"></slot>
            </div>
            </template>
            <div class="col-auto me-auto" v-if="!$slots['top_page_options'] && page_options!=null && page_size!=null">
                <div class="float-start">
                <label class="col-form-label">Rows</label>
                </div>
                <div class="ms-2 float-start">
                    <select class="form-select" v-model="this.page_size" @change="this.page_index=1;onRefresh">
                        <template v-for="i in page_options" v-bind:key="i">
                            <option :value="i">{{i}}</option>
                        </template>
                    </select>
                </div>
            </div>
            <template v-if="$slots['top_content']">
            <div class="col-auto me-auto">
                <slot name="top_content"></slot>
            </div>
            </template>
            <template v-if="$slots['top_pagination']">
            <div class="col-auto me-auto">
                <slot name="top_pagination"></slot>
            </div>
            </template>
            <div class="col-auto" v-if="!$slots['top_pagination'] && page_options!=null && page_size!=null">
                Total Pages:{{totalPages}}
                    Visible Pages:{{calculateVisiblePages}}
                <ul class="pagination justify-content-end">
                    <li class="page-item" :class="{'disabled':(page_index<=1)}">
                        <a @click="onChangePage(1)" class="page-link" href="#" tabindex="-1" aria-disabled="true">First</a>
                    </li>
                    <li class="page-item" :class="{'disabled':(page_index<=1)}">
                        <a @click="onChangePage((page_index-1))" class="page-link" href="#" tabindex="-1" aria-disabled="true">Previous</a>
                    </li>
                    <template v-for="i in calculateVisiblePages" v-bind:key="i">
                        <li @click="onChangePage(i)" class="page-item" :class="{'active':(i==page_index)}"><a class="page-link" href="#">{{i}}</a></li>    
                    </template>
                    <li class="page-item" :class="{'disabled':(page_index>=totalPages)}">
                        <a @click="onChangePage((page_index+1))" class="page-link" href="#">Next</a>
                    </li>
                    <li class="page-item" :class="{'disabled':(page_index>=totalPages)}">
                        <a @click="onChangePage(totalPages)"  class="page-link" href="#">Last</a>
                    </li>
                </ul>
            </div>
        </div>
        <table :class="css">
            <thead>
                <tr>
                    <template v-for="col in columns" v-bind:key="col">
                        <template  v-if="$slots['column_'+col.name]">
                            <slot :name="'column_' + col.name" :col="col" :index="index"></slot>
                        </template>
                        <template  v-if="!$slots['column_'+col.name]">
                            <th :class="col.column_css_object" :style="col.column_style_object" @click="onSort(col);">{{col.display_name}}</th>
                        </template>
                    </template>
                </tr>
            </thead> 
            <tbody>
                <tr v-for="row in rows" v-bind:key="row">
                    <template v-for="col in columns" v-bind:key="col">
                        <template v-if="$slots['row_'+col.name] && row.is_edit==false">
                            <slot :name="'row_' + col.name" :col="col" :row="row" :index="index"></slot>
                        </template>
                        <template  v-if="!$slots['row_'+col.name] && row.is_edit==false">
                            <td style="cursor:pointer" @click="onEdit(row)" :class="col.row_css_object" :style="col.row_style_object">{{row[col.name]}}</td>
                        </template>
                        <template v-if="$slots['row_edit_'+col.name] && row.is_edit==true">
                            <slot :name="'row_edit_' + col.name" :col="col" :row="row" :index="index"></slot>
                        </template>
                    </template>
                </tr>
            </tbody>
            <tfoot v-if="$slots['footer']">
                <slot name="footer" :rows="rows"></slot>
            </tfoot>
        </table> 
</div>
</template>
<style> 
</style>
<script>
    export default {
        name: "BootstrapTable",
        props: {
           total: Number,rows: [],columns: [],css: String
           ,rp:{type:Number,default:25}
           ,page_options:{ type:Array,default() { return [10,25,50,100,200]}}
           ,sortname: String
           ,sortorder: String
           ,visible_pages: {type:Number,default:5}
           ,refresh:Function,save:Function
        }, 
        data() {
           return {
               before_rows: [],
               sort_name: '',
               sort_order: '',
               page_size: 0,
               page_index: 1
           }
        },
        mounted() {
              this.sort_name = this.$props.sortname;
              this.sort_order = this.$props.sortorder;
              this.page_size = this.$props.rp;
              //console.log('this.sort_name',this.sort_name);
              //console.log('this.sort_order',this.sort_order);
        },
        computed:{
            totalPages() {
                return Math.ceil(this.$props.total/this.page_size);
            },
            calculateVisiblePages(){
                var half=Math.floor(this.$props.visible_pages/2);
                var start=this.page_index-half+1-this.$props.visible_pages%2;
                var end=this.page_index+half;
                //console.log('1 page_index='+this.page_index+'half='+half+'start='+start+'end='+end);
                 // handle boundary case
                if(start<=0) {
                    start=1;
                    end=this.$props.visible_pages;
                }
                 //console.log('2 page_index='+this.page_index+'half='+half+'start='+start+'end='+end);
                var tp = this.totalPages;
                //console.log('tp=',tp);
                if(end>tp) {
                    start=tp-this.$props.visible_pages+1;
                    end=tp;
                }
                //console.log('page_index=',this.page_index,'half=',half,'start=',start,'end=',end);
                if(start<=0) {
                    start=1;
                    end=this.$props.visible_pages;
                }
                if(end>tp){
                    end = tp;
                }
                var temppages = [];
                var itPage=start;
                while(itPage<=end) {
                    temppages.push(itPage);
                    itPage++;
                }
                return temppages;
            }
        },
        methods: {
            onChangePage: function(i){
                this.page_index = i;
                this.onRefresh();
            },
            onEdit: function(row) {
                row.is_edit = true;
                row.bt_index = this.before_rows.length;
                var br = Object.assign({}, row);
                this.before_rows.push(br);
                //console.log(this.before_rows);
            },
            onSave: function(row) {
                for(var i = 0;i<this.before_rows.length;i++){
                    var br = this.before_rows[i];
                    if(br.bt_index == row.bt_index) {
                        this.before_rows.splice(i,1);
                    }
                } 
                row.is_edit = false;
                row.bt_index = -1;
                if(this.$props.save)
                    this.$props.save(row);
            },
            onCancelEdit: function(row){
                row.is_edit = false;
                var br = null;
                var i,j;
                for(i = 0;i<this.before_rows.length;i++){
                    br = this.before_rows[i];
                    if(br.bt_index == row.bt_index) {
                        for(j = 0;j<this.$props.rows.length;j++){
                            if(this.$props.rows[j].bt_index == br.bt_index){
                                br.is_edit=false;
                                br.bt_index=-1;
                                this.$props.rows.splice(j,1,Object.assign({}, br));
                                break;
                            }
                        }
                        this.before_rows.splice(i,1);
                    }
                } 
            }
            ,onSort: function(col) {
                this.sort_name = col.name;
  if(this.sort_order =='asc')
                    this.sort_order = 'desc';
                else
                    this.sort_order = 'asc';

                    this.onRefresh();
            }
            ,onRefresh: function() {
                var data = {
                    'sort_name': this.sort_name
                    ,'sort_order': this.sort_order
                    ,'page_index': this.page_index
                    ,'page_size': this.page_size
                } 
                if(this.$props.refresh)
                    this.$props.refresh(data);
            }
        }
    }
</script>