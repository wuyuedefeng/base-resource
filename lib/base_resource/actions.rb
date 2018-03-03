require('base_resource/instance_methods')
require('base_resource/pagination')
require('base_resource/search')
module BaseResource
  module Actions
    include InstanceMethods
    include Pagination
    include Search

    def index resources = nil
      resources = find_resources resources
      if block_given?
        resources = yield(resources)
      end
      instance_variable_set("@#{resources_name(resources)}", paginate(resources.order(id: :desc)))
    end
    alias_method :br_index, :index
    # or in ruby > 2.2, child can call parent method use below method
    # method(:index).super_method.call

    def show
      resource = find_resource
      instance_variable_set("@#{resource_name(resource)}", resource)
      if block_given?
        yield(resource)
      end
    end
    alias_method :br_show, :show

    def create
      form = form_const.new(resource_klass.new)
      if form.validate(params)
        instance_variable_set("@#{resource_name(form.model)}", form.model)
        if block_given?
          form.save do |hash|
            yield hash, form
          end
          render json: { msg: :successfully_create }, status: 200
        else
          if form.save
            render json: { msg: :successfully_create }, status: 200
          else
            render json: { msg: form.errors.full_messages.first || form.model.errors.full_messages.first }, status: 422
          end
        end
      else
        render json: { msg: form.errors.full_messages.first }, status: 422
      end
    end
    alias_method :br_create, :create

    def update resource = nil
      form = form_const.new(resource || resource_klass.find(params[:id]))
      if form.validate(params) && form.save
        resource = form.model
        instance_variable_set("@#{resource_name(resource)}", resource)
        if block_given?
          yield resource
        else
          render json: { msg: :successfully_update }, status: 200
        end
      else
        render json: { msg: form.errors.full_messages.first || form.model.errors.full_messages.first }, status: 422
      end
    end
    alias_method :br_update, :update

    def destroy
      resource = destroy_resource
      instance_variable_set("@#{resource_name(resource)}", resource)
      if block_given?
        yield resource
      else
        render json: { msg: :successfully_destroy }, status: 200
      end
    end
    alias_method :br_destroy, :destroy

    protected

    def find_resources resources = nil
      (resources || resource_klass).ransack(prepare_search_condition).result(distinct: true)
    end

    def find_resource(id = nil)
      id ||= respond_to?(:params) && params.is_a?(ActionController::Parameters) && params[:id]
      resource_klass.find id
    end

    def destroy_resource(id = nil)
      id ||= respond_to?(:params) && params.is_a?(ActionController::Parameters) && params[:id]
      resource_klass.destroy id
    end

    def form_const
      namespaces = self.class.to_s.split("::")
      const = while namespaces.present?
                const = "#{namespaces.join('::')}::#{resource_klass_name}Form::#{action_name.classify}".constantize rescue nil
                break const if const
                namespaces.pop
              end
      const || "#{resource_klass_name}Form::#{action_name.classify}".try(:constantize)
    end
  end
end
