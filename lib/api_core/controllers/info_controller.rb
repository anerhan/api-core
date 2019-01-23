module ApiCore
  module Controllers
    module InfoController
      def index
        render json: ApiCore.info
      end
    end
  end
end
