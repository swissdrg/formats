module Error
  class InputValidationError < StandardError
    attr_reader :status, :error, :message

    def initialize(_message = nil)
      @error = 422
      @status = :unprocessable_entity
      @message = _message || 'Invalid input'
    end
  end
end