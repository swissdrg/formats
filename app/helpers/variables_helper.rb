module VariablesHelper
  # Checks whether a variable has no parameters set.
  # False if any parameter has a value other than "". True otherwise.
  def variable_is_empty(variable_params)
    variable_is_empty = true
    [:number, :description, :length, :var_type].each do |key|
      unless variable_params[key.to_sym].nil? then
        variable_is_empty &= (variable_params[key.to_sym].to_s.length == 0)
      end
      break if !(variable_is_empty)
    end
    return variable_is_empty
  end
end