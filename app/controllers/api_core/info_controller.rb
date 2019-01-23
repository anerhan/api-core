module ApiCore
  class InfoController < ApplicationController
    def index
      render json: ApiCore.info
    end
  end
end
