import BaseView          from "./base_view";
import AdminBaseView     from "./admin_base_view";
import AdminProductView  from "./admin/products";
import AdminOptionTypeView  from "./admin/option_types";
import AdminCartView     from "./admin/cart";
import AdminCheckoutView from "./admin/checkout";
import AdminCountryView  from "./admin/countries";
import AdminOrderView    from "./admin/orders";
import AdminZoneView     from "./admin/zones";

// add all the views here.
const views = {
    AdminProductView,
    AdminOptionTypeView,
    AdminCartView,
    AdminCheckoutView,
    AdminCountryView,
    AdminOrderView,
    AdminZoneView
};

export default function viewToRender(view) {
  let viewLookUp   = view.split(".");
  const actionName = viewLookUp.pop();
  const viewName   = viewLookUp.join("");
  let actionLookup = views[viewName];

  if (actionLookup) {
    return actionLookup(actionName);
  } else {
    if (viewLookUp[0] == 'Admin') {
      return AdminBaseView;
    } else {
      return BaseView;
    }
  }
}
