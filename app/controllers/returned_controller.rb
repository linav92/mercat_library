class ReturnedController < ApplicationController
    skip_before_action :verify_authenticity_token
    def libro_retornado
    end
end
