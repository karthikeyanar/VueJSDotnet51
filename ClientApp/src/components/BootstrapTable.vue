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
                    <select class="form-select">
                        <template v-for="i in page_options" v-bind:key="i">
                            <option value="{{i}}">{{i}}</option>
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
                <ul class="pagination justify-content-end">
                    <li class="page-item" :class="{'disabled':(page_index<=1)}">
                        <a class="page-link" href="#" tabindex="-1" aria-disabled="true">Previous</a>
                    </li>
                    <template v-for="i in total_pages" v-bind:key="i">
                        <li class="page-item" :class="{'active disabled':(i==page_index)}"><a class="page-link" href="#">{{i}}</a></li>    
                    </template>
                    <li class="page-item" :class="{'disabled':(page_index>=total_pages)}">
                        <a class="page-link" href="#">Next</a>
                    </li>
                </ul>
            </div>
        </div>
        <table :class="class_name">
            <thead>
                <tr>
                    <template v-for="col in columns" v-bind:key="col">
                        <template  v-if="$slots['column_'+col.name]">
                            <slot :name="'column_' + col.name" :col="col" :index="index"></slot>
                        </template>
                        <template  v-if="!$slots['column_'+col.name]">
                            <th :class="col.column_css_object" :style="col.column_style_object" @click="this.sort_name=col.name;onRefresh(col);">{{col.display_name}}</th>
                        </template>
                    </template>
                </tr>
            </thead> 
            <tbody>
                <tr v-for="row in rows" v-bind:key="row">
                    <template v-for="col in columns" v-bind:key="col">
                        <template  v-if="$slots['row_'+col.name]">
                            <slot :name="'row_' + col.name" :row="row" :index="index"></slot>
                        </template>
                        <template  v-if="!$slots['row_'+col.name]">
                            <td :class="col.row_css_object" :style="col.row_style_object">{{row[col.name]}}</td>
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
           total: Number,rows: [],columns: [],class_name: String,page_size:Number,page_options:[]
        },
        emits: ["onRefresh"],
        data() {
           return {
               sort_name: this.$props.sort_name,
               sort_order: this.$props.sort_order,
               page_index: 1,
               total_pages: Math.ceil(this.$props.total/this.$props.page_size)
           }
        },
        methods: {
            onRefresh: function() {
                if(this.sort_order =='asc')
                    this.sort_order = 'desc';
                else
                    this.sort_order = 'asc';

                var data = {
                    'sort_name': this.sort_name
                    ,'sort_order': this.sort_order
                    ,'page_index': this.page_index
                    ,'page_size': this.$props.page_size
                } 
                this.$emit('onRefresh',data)
            }
        }
    }
</script>