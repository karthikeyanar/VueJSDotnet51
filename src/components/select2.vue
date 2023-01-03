<template>
    <input type="hidden" />
</template>
<style>
</style>

<script>
    import $ from 'jquery';
    export default {
        name: "Select2",
        props: {
            placeholder: { type: String, default: '' }
            , minimumInputLength: { type: Number, default: 0 }
            , maximumSelectionSize: { type: Number, default: 1000 }
            , minimumResultsForSearch: { type: Number, default: 0 }
            , multiple: { type: Boolean, default: true }
            , allowClear: { type: Boolean, default: false }
            , delay: { type: Number, default: 300 }
            , source: { type: Function }
            , data: { type: Function }
            , change: { type: Function }
            , css: { type: String, default: '' }
            , style: { type: String, default: '' }
            , field: String
            , root: Object
        },
        mounted() {
            var self = this;
            var $element = $(this.$el);
            $element = $(this.$el).val("").select2({
                placeholder: self.$props.placeholder,
                minimumInputLength: self.$props.minimumInputLength,
                maximumSelectionSize: self.$props.maximumSelectionSize,
                minimumResultsForSearch: self.$props.minimumResultsForSearch,
                multiple: self.$props.multiple,
                allowClear: self.$props.allowClear,
                delay: self.$props.delay,
                query: function (q) {
                    if (self.$props.source)
                        self.$props.source(q);
                },
            }).on('change', function () {
                var d = $element.select2('data');
                console.log('d=', d);
                var ids = '';
                $.each(d, function (i, r) {
                    ids += r.id + ',';
                });
                if (ids != '') {
                    ids = ids.substring(0, ids.length - 1);
                }
                self.root[self.field] = ids;
                if (self.$props.change)
                    self.$props.change(d);
            });
            //console.log(self.$props.data);
            if (self.$props.data) {
                var options = self.$props.data(self.root);
                $element.select2("data", options);
            }
        },
        beforeUnmount: function () {
            $(this.$el).select2('destroy');
        }
    }
</script>