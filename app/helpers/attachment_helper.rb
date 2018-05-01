# Read and write file attachments for Formats
module AttachmentHelper
  def read_attachment(format)
    return if !format.attachment.present? || !File.readable?(format.attachment.file.path)
    File.read(format.attachment.file.path)
  end

  def update_attachment(format, json)
    return if !format.attachment.present? || !File.writable?(format.attachment.file.path)
    # TODO: Create new attachment if not present or writable

    File.open(format.attachment.file.path, 'w') do |f|
      f.write(json)
      true
    end
  end
end
