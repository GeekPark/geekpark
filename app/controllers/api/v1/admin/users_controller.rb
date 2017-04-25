module API::V1::Admin
  class UsersController < AdminController
    resource_description { short '用戶相關 API (管理介面)' }

    api :GET, '/admin/permissions', 'Get current user\' permissions'
    def permissions
      success do
        {
          roles: current_roles,
          permissions: CantCantCant.allowed_actions_for(current_roles)
        }
      end
    end
  end
end
