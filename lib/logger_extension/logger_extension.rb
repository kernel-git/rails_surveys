module LoggerExtension
  def log_exception(e)
    message = "Exception catched!\n"
    message += "Exeption type: #{e.class.name}\n"
    message += "Exeption message: #{e.message}\n"
    message += "~~~~~~~Stack trace~~~~~~~\n"
    e.backtrace.each { |line| message += "#{line}\n" }
    message += '~~~~~~~~~~~~~~~~~~~~~~~~~'
    Rails.logger.error message
  end
end
