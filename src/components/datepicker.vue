<template> 
  <input class="form-control" :placeholder="placeholder" :class="css" :style="style" @input="$emit('update:modelValue', $event.target.value)" />
</template>
<style>   
.datepicker {
  transform: translate(0, 5.7em);
}
</style>
<script>
  import $ from 'jquery';
  import helper from '@/common/helper';
  export default {
      name: "DatePicker",
      props: {
         autoclose:{type:Boolean,default:true}
         ,todayHighlight:{type:Boolean,default:true}
         ,dateFormat:{type:String,default:'dd/M/yyyy'}
         ,momentFormat:{type:String,default:'DD/MMM/YYYY'}
         ,css:{type:String,default:''}
         ,style:{type:String,default:''}
         ,root:Object
         ,field:String
         ,placeholder:{type:String,default:''}
      }, 
      emits: ['update:modelValue'],
      mounted() {
          var self = this;
          var v = '';
          if(self.root){
            v = self.root[self.field];
          }
          $(this.$el).val(helper.formatDate(v,self.$props.momentFormat)).datepicker({
              'autoclose': this.$props.autoclose
              ,'todayHighlight': this.$props.todayHighlight
              ,'format': this.$props.dateFormat
              //,'onSelect': function(date) {
                //  console.log('onSelect date=',date);
                  //self.$emit('update:modelValue',date)
              //}
          }).on('change',function(e){
              console.log('change e=',e);
              console.log('change e=', e.target.value + ',momentFormat=' + self.$props.momentFormat);
              var d = helper.formatDate(e.target.value, self.$props.momentFormat);
              console.log('change d=' + d);
              self.root[self.field] = d;
          }).on('changeDate',function(e){
              console.log('changeDate e',e);
              console.log('changeDate e', e.date + ',momentFormat=' + self.$props.momentFormat);
              var d = helper.formatDate(e.date, self.$props.momentFormat);
              console.log('change d2=' + d);
          });
      },
      beforeUnmount: function() {
          $(this.$el).datepicker('hide').datepicker('destroy');
      }
  }
</script>