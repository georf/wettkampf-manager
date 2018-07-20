class Certificates::ListsController < ApplicationController
  implement_crud_actions
  before_action :assign_resource_for_export, only: :export

  def export
    if request.format.pdf? && create_resource
      @certificates_template = @certificates_list.template
      @score_result = @certificates_list.result.decorate
      @rows = @certificates_list.rows.map(&:decorate)
      @background_image = @certificates_list.background_image
      page_title('Urkunde', margin: [0, 0, 0, 0])
    else
      redirect_to action: :new
    end
  end

  protected

  def certificates_list_params
    params.require(:certificates_list)
          .permit(:template_id, :background_image, :score_result_id, :competition_result_id, :group_score_result_id)
  end

  def build_resource
    resource_class.new(score_result_id: params[:score_result_id], competition_result_id: params[:competition_result_id])
  end

  def after_create; end

  def assign_resource_for_export
    assign_new_resource
  end
end
