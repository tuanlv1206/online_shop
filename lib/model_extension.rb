module ModelExtension
  def self.included(base)
    base.extend ClassMethods
    base.after_save do
      if @pending_attachments
        @pending_attachments.each do |pa|
          old_attachments = attachments.where(role: pa[:role]).pluck(:id)
          attachments.create(file: pa[:file], role: pa[:role])
          attachments.where(id: old_attachments).destroy_all
        end
        @pending_attachments = nil
      end
    end
  end

  module ClassMethods
    def attachment(name)
      unless reflect_on_all_associations(:has_many).map(&:name).include?(:attachments)
        has_many :attachments, as: :parent, dependent: :destroy, class_name: 'Attachment'
      end

      has_one name, -> { select(:id, :token, :parent_id, :parent_type, :file_name, :file_type, :file_size).where(role: name) }, class_name: 'Attachment', as: :parent

      define_method "#{name}_file" do
        instance_variable_get("@#{name}_file")
      end

      define_method "#{name}_file=" do |file|
        instance_variable_set("@#{name}_file", file)
        if file.is_a?(ActionDispatch::Http::UploadedFile)
          @pending_attachments ||= []
          @pending_attachments << { role: name, file: file }
        end
      end
    end
  end
end

