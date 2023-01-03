<template>
  <div>
    <div class="float-end">
    <nav aria-label="Page navigation example">
      <ul class="pagination justify-content-end">
      <li class="page-item" v-bind:class="{'disabled': data.pageIndex <= 1 }">
        <a
          class="page-link"
          href="#"
          aria-label="Previous"
          v-on:click="changePage(data.pageIndex-1)"
        >
          <span aria-hidden="true">&laquo;</span>
        </a>
      </li>
   
        <li v-for="i in pages" :key="i" class="page-item" v-bind:class="{'active':data.pageIndex == i}">
          <a class="page-link" href="#" v-on:click="changePage(i)">{{i}}</a>
        </li> 
      <li
        class="page-item"
        v-bind:class="{ disabled: data.pageIndex >= data.totalPages }"
      >
        <a
          class="page-link"
          href="#"
          aria-label="Next"
          v-on:click="changePage(data.pageIndex+1)"
        >
          <span aria-hidden="true">&raquo;</span>
        </a>
      </li>
    </ul>
    </nav>
  </div>
  <div class="float-end" style="margin-right:20px;">
      <select class="form-select" aria-label="Default select example" v-model="data.pageSize" v-on:change="changeRows()">
      <option v-for="item in data.pageSizeOptions" :key="item" v-bind:selected="item==data.pageSize">
        {{item}}
      </option> 
    </select>
    </div><div class="clearfix"></div>
</div>
</template>
<style>
</style>
<script>
export default {
  props: {
         data: Object,
         pageRange: Number, 
         onChange: Function
  }, 
  data() {
    return {
      count: 0,
    };
  },
  methods: {
    init() {
      var self = this;
      self.refresh();
    },
    refresh() {
      var self = this;
      // console.log(
      //   "self.data.total=" +
      //     self.data.total +
      //     ",self.data.pageSize=" +
      //     self.data.pageSize
      // );
      self.data.totalPages = Math.ceil(self.data.total / self.data.pageSize);
      self.generatePages();
    },
    generatePages: function () {
      this.pages = [];
      // console.log(
      //   "this.data.totalPages=" +
      //     this.data.totalPages +
      //     ",this.pageRange=" +
      //     this.pageRange 
      // );
      if (this.data.totalPages <= this.pageRange) {
        for (let index = 1; index <= this.data.totalPages; index++) {
          this.pages.push(index);
        }
      } else {
        const halfPageRange = Math.floor(this.pageRange / 2);
        //console.log("halfPageRange=" + halfPageRange);

        let selectedRangeLow = 0;
        if (this.data.pageIndex - halfPageRange > 0) {
          selectedRangeLow = this.data.pageIndex - halfPageRange;
        }
        //console.log("selectedRangeLow1=" + selectedRangeLow);

        if(selectedRangeLow<=0){
          selectedRangeLow = 1;
        }

        let selectedRangeHigh = selectedRangeLow + this.pageRange - 1;
        if (selectedRangeHigh >= this.data.totalPages) {
          selectedRangeHigh = this.data.totalPages;
          selectedRangeLow = selectedRangeHigh - this.pageRange + 1;
        }

        // console.log(
        //   "selectedRangeLow=" +
        //     selectedRangeLow +
        //     ",selectedRangeHigh=" +
        //     selectedRangeHigh
        // );
        for (
          let i = selectedRangeLow;
          i <= selectedRangeHigh && i <= this.data.totalPages;
          i++
        ) {
          //console.log("i=", i);
          this.pages.push(i);
        }
      }
      //console.log("pages=", this.pages);
    },
    changePage(value) {
      var self = this;
      if (value < 1 || value > self.data.totalPages) {
        return;
      }
      self.data.pageIndex = value;
      self.refresh();
      if (self.onChange) self.onChange();
    },
    changeRows() {
      var self = this;
      self.data.pageIndex = 1;
      self.refresh();
      if (self.onChange) self.onChange();
    }
  },
  mounted() {
    let self = this;
    self.init();
  }
}
</script>