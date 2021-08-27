<template>
<div>
   <bootstrap-table class_name="table table-bordered" :total="total" :rows="rows" :columns="columns" ref="bstable">
     <template v-slot:row_edit_name="slotProps">
       <td :style="slotProps.col.row_style_object"><input type="text" v-model="slotProps.row.name" class="form-control form-control-sm" /></td>
     </template>
     <template v-slot:row_edit_number="slotProps">
       <td :style="slotProps.col.row_style_object"><input type="text" v-model="slotProps.row.number" class="form-control form-control-sm" /></td>
     </template>
     <template v-slot:row_action_button="slotProps">
       <td :style="slotProps.col.row_style_object">
         <i class="bi bi-pencil" style="cursor:pointer" @click="$refs.bstable.onEdit(slotProps.row)"></i>
       </td>
     </template>
     <template v-slot:row_edit_action_button="slotProps">
      <td :style="slotProps.col.row_style_object">
         <button type="button" @click="$refs.bstable.onSave(slotProps.row)" class="btn btn-sm btn-primary">Save</button>
         <button type="button" @click="$refs.bstable.onCancelEdit(slotProps.row);" class="btn btn-sm btn-danger ms-4">Cancel</button>
      </td>
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
          rows: [{'name':'karthi','number':'22323','is_edit':false},{'name':'raja','number':'31123','is_edit':false}],
          columns: [
            {'name':'name','display_name':'Name','is_sort':true}
          ,{'name':'number','display_name':'Number','is_sort':false
          ,'column_css_object': ['text-end','text-start']
          ,'row_css_object':['text-end','text-start']
          ,'column_style_object': {'width':'1px'}
          ,'row_style_object':{'width':'1px'}
          }
          ,{'name':'action_button','display_name':'','is_sort':false ,'column_style_object': {'width':'200px'}
          ,'row_style_object':{'width':'100px','white-space':'nowrap'}}]
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
