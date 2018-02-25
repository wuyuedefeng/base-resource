module BaseResource
  module InstanceMethods
    # name of the singular resource eg: 'user'
    def resource_name(resource = nil)
      resource ? resource.class.to_s.singularize.downcase : controller_name.singularize
    end

    # name of the resource collection eg: 'users'
    def resources_name(resources = nil)
      resources ? resources.model.to_s.pluralize.downcase : controller_name.pluralize
    end

    # eg: return 'User' string
    def resource_klass_name
      resource_name.classify
    end

    #  eg: return User klass
    def resource_klass
      resource_klass_name.constantize
    end
  end
end