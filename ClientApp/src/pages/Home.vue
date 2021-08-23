<template>
<div>
   <bootstrap-table class_name="table table-bordered" :total="total" :rows="rows" :columns="columns">
     <template v-slot:column_number="slotProps">
       <th>{{slotProps.col.name}}</th>
     </template>
     <template v-slot:row_name="slotProps">
       <td>{{slotProps.row.name}}</td>
     </template>
     <template v-slot:row_number="slotProps">
       <td class="text-end">{{slotProps.row.number}}</td>
     </template>
   </bootstrap-table> 
   <bootstrap-table class_name="table table-bordered"  @onRefresh="onRefresh" :page_options="['10','20','30']" page_size="10" sort_name="name" sort_order="asc" :total="total" :rows="rows" :columns="columns">
     <template v-slot:top_content>
        <div class="float-start"><button type="button" class="btn btn-orimary">Refresh</button></div>
     </template>
   </bootstrap-table> 
</div>
</template>

<script>
import BootstrapTable from '@/components/BootstrapTable.vue';
export default {
  components: { BootstrapTable },
  name: 'Home',
  props: {
    msg: String
  },
  data() {
      return {
          total: 2,
          rows: [{'name':'karthi','number':'22323'},{'name':'raja','number':'31123'}],
          columns: [{'name':'name','display_name':'Name','is_sort':true
          },{'name':'number','display_name':'Number','is_sort':false
          ,'column_css_object': ['text-end','text-start']
          ,'row_css_object':['text-end','text-start']
          ,'column_style_object': {'background':'red','color':'#fff'}
          ,'row_style_object':{'background':'gray','color':'#333'}
          }]
      }
  },
  methods: {
    onRefresh: function(data){
      console.log('data=',data);
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
