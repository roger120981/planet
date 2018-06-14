import BaseProductView from "./base_product_view";

export default class EditView extends BaseProductView {
  mount() {
    super.mount();
    this.handleAdd();
    this.handleDelete();

      $( ".datepicker" ).datepicker({
          autoSize: true,
          showOn: "focus",
          dateFormat: "yy-mm-dd"
      });

  }

  unmount() {
    super.unmount();
  }
    handleAdd() {
        $(document).on("click", "#add_option_value, #add_product_option_type, #add_category, #add_product_category", function(e) {
            e.preventDefault();
            let time = new Date().getTime();
            let template = $(this).data("template");
            var uniq_template = template.replace(/\[0\]/g, `[${time}]`);
            uniq_template = uniq_template.replace(/_0_/g, `_${time}_`);
            $(this).after(uniq_template);
        });
    }

    handleDelete() {
        $(document).on("click", "#delete_option_value, #delete_product_option_type, #delete_category, #delete_product_category", function(e) {
            e.preventDefault();
            $(this).parent().remove();
        });
    }
}
