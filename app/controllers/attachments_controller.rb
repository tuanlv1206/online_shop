class AttachmentsController < ApplicationController
  def destroy
    @attachment = Attachment.find_by!(token: params[:id])
    @attachment.destroy
    respond_to do |wants|
      wants.html { redirect_to request.referer, notice: t('shop.attachments.remove_notice') }
      wants.json { render status: 'complete' }
    end
  end
end
