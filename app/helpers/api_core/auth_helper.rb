module ApiCore
  module AuthHelper
    def signed_in?
      !current_user.nil?
    end

    def current_user
      warden.user
    end

    def warden
      request.env['warden']
    end

    def authenticate_user!
      warden.authenticate!
    end
  end
end
