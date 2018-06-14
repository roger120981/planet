import BaseView          from "./base_view";
import AdminBaseView     from "./admin_base_view";
import AdminProductView  from "./admin/products";
import AdminOptionTypeView  from "./admin/option_types";

// add all the views here.
const views = {
    AdminProductView,
    AdminOptionTypeView
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
