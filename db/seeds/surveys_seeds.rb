# frozen_string_literal: true

class SurveysSeeds
  def initialize; end

  def perform
    surveys = []
    [
      { label: 'University' },
      { label: 'Social' }
    ].each { |hash| surveys << Survey.new(hash) }
    surveys[0].employer = Employer.find_by(label: 'BSUIR')
    surveys[1].employer = Employer.find_by(label: 'BSTU')
    begin
      surveys.each(&:save!)
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved => e
      log_exception(e)
    end
  end
end
