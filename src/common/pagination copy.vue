// export default {
//     props: {
//         data: Object,
//         pageRange: Number,
//         marginPages: Number,
//         onChange: Function
//     }, 
//     data() {
//         return {
//             pages:[]
//         }
//     },
//     template: `<nav aria-label="Page navigation example">
//         <ul class="pagination">
//         <li class="page-item" v-bind:class="{'disabled':data.pageIndex<=1}">
//             <a class="page-link" href="#" aria-label="Previous" v-on:click="changePage(1)">
//             <span aria-hidden="true">&laquo;</span>
//             </a>
//         </li>
//         <template v-for="i in pages">
//         <li class="page-item" v-bind:class="{'active':data.pageIndex==i}"><a class="page-link" href="#">{{i}}</a></li>
//         </template>
//         <li class="page-item" v-bind:class="{'disabled':data.pageIndex>=data.totalPages}">
//             <a class="page-link" href="#" aria-label="Next" v-on:click="changePage(data.totalPages)">
//             <span aria-hidden="true">&raquo;</span>
//             </a>
//         </li>
//         </ul>
//     </nav>`,
//     methods: {
//         init() {
//             var self = this;
//             self.refresh();
//         },
//         refresh() {
//             var self = this;
//             console.log('self.data.total='+self.data.total+',self.data.pageSize='+self.data.pageSize);
//             self.data.totalPages = Math.ceil(self.data.total / self.data.pageSize);
//             self.generatePages();
//         },
//         generatePages: function () {
//             this.pages = [];
//             console.log('this.data.totalPages='+this.data.totalPages+',this.pageRange='+this.pageRange+',maginPages='+this.marginPages);
//             if (this.data.totalPages <= this.pageRange) {
//                 for (let index = 0; index < this.data.totalPages; index++) {
//                     this.pages.push(index);
//                 }
//             } else {
//                 const halfPageRange = Math.floor(this.pageRange / 2)
// console.log('halfPageRange='+halfPageRange);
//                 // 1st - loop thru low end of margin pages
//                 // for (let i = 0; i < this.marginPages; i++) {
//                 //     pages[i] = i;
//                 // }

//                 // 2nd - loop thru data.pageIndex range
//                 let selectedRangeLow = 0;
//                 if (this.data.pageIndex - halfPageRange > 0) {
//                     selectedRangeLow = this.data.pageIndex - 1 - halfPageRange;
//                 }

//                 let selectedRangeHigh = selectedRangeLow + this.pageRange - 1;
//                 if (selectedRangeHigh >= this.data.totalPages) {
//                     selectedRangeHigh = this.data.totalPages - 1;
//                     selectedRangeLow = selectedRangeHigh - this.pageRange + 1;
//                 }

//                 console.log('selectedRangeLow='+selectedRangeLow+',selectedRangeHigh='+selectedRangeHigh);
//                 for (let i = selectedRangeLow; i <= selectedRangeHigh && i <= this.data.totalPages - 1; i++) {
//                     console.log('i=',i);
//                     this.pages.push(i);
//                 }

//                 // // Check if there is breakView in the left of data.pageIndex range
//                 // if (selectedRangeLow > this.marginPages) {
//                 //     //setBreakView(selectedRangeLow - 1)
//                 // }

//                 // // Check if there is breakView in the right of data.pageIndex range
//                 // if (selectedRangeHigh + 1 < this.data.totalPages - this.marginPages) {
//                 //     //setBreakView(selectedRangeHigh + 1)
//                 // }

//                 // // 3rd - loop thru high end of margin pages
//                 // for (let i = this.data.totalPages - 1; i >= this.data.totalPages - this.marginPages; i--) {
//                 //     pages[i] = i;
//                 // }
//             }
//             console.log('pages=',this.pages);
//         },
//         changePage(value) {
//             var self = this;
//             if (value < 1 || value > self.data.totalPages) {
//                 return;
//             }
//             self.data.pageIndex = value;
//             self.refresh();
//             if (self.onChange)
//                 self.onChange();
//         }
//     },
//     mounted() {
//         let self = this;
//         self.init();
//     }
// }

export default {
    data() {
      return {
        count: 0
      }
    },
    template: `<button @click="count++">You clicked me {{ count }} times.</button>`,
     mounted() {
        console.log('start');
     }
  }