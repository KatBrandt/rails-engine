class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private

  def not_found(e)
    render json: { errors: e.message}, status: 404
  end
end
