defmodule Excommerce.Validations.Date do
  import Ecto.Changeset, only: [validate_change: 3]
  
  def validate_not_past_date(changeset, field, options \\ []) do
    validate_gt_date(changeset, field, Date.utc_today, [message: options[:message] || "can not be past date"])
  end

  # Better to add proper validation for Date ref_date
  def validate_gt_date(changeset, field, ref_date, options \\ []) do
    validate_change(changeset, field, fn _,value ->
      case Date.compare(value, ref_date) do
        :lt -> [{field, options[:message] || "should be greater or same as #{Date.to_string(ref_date)}"}]
        _  -> []
      end
    end)
  end
  
  def validate_lt_date(changeset, field, ref_date, options \\ []) do
    validate_change(changeset, field, fn _,value ->
      # Note the changed references
      case Date.compare(ref_date, value) do
        :lt -> [{field, options[:message] || "should be less or same as #{Date.to_string(ref_date)}"}]
        _  -> []
      end
    end)
  end
end
