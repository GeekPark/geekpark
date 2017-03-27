module APIFindModelHelper
  def find_record(model_name = auto_model_name)
    model = model_name.to_s.classify.constantize
    id_field = "#{model_name}_id".intern
    instance_var = "@#{model_name}"
    method_name = "find_#{model_name}".intern

    define_method method_name do
      instance = model.find(params[id_field] || params[:id])
      instance_variable_set(instance_var, instance)
    end

    private method_name
    method_name
  end

  private

  def auto_model_name
    name
      .demodulize
      .sub(/Controller$/, '')
      .underscore
      .singularize
      .intern
  end
end
