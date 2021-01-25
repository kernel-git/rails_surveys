# frozen_string_literal: true

class EmployersSeeds
  include LoggerExtension

  def initialize; end

  def perform
    [{
      label: 'BSUIR',
      public_email: 'kanc@bsuir.by',
      phone: '88005553535',
      address: 'Statue of Liberty, Liberty Island New York, NY 10004',
      logo_url: 'https://www.graphicsprings.com/filestorage/stencils/29c2824f9ba81b8e219075f347cf5e6b.svg'
    },
     {
       label: 'BSU',
       public_email: 'bsu@bsu.by',
       phone: '88005553535',
       address: 'Statue of Liberty, Liberty Island New York, NY 10004',
       logo_url: 'https://www.graphicsprings.com/filestorage/stencils/d815a666e1de0fb6c31f76574c33cbf7.svg'
     },
     {
       label: 'BSTU',
       public_email: 'rector@belstu.by',
       phone: '88005553535',
       address: 'Statue of Liberty, Liberty Island New York, NY 10004',
       logo_url: 'https://www.graphicsprings.com/filestorage/stencils/1aed58b953d14e20bb583a893d057e5c.svg'
     },
     {
       label: 'BSMU',
       public_email: 'bsmu@bsmu.by',
       phone: '88005553535',
       address: 'Statue of Liberty, Liberty Island New York, NY 10004',
       logo_url: 'https://www.graphicsprings.com/filestorage/stencils/837d16f76770c867a23c1857fae9c39c.svg'
     },
     {
       label: 'BSAI',
       public_email: 'NothingHere@gmail.com',
       phone: '88005553535',
       address: 'Statue of Liberty, Liberty Island New York, NY 10004',
       logo_url: 'https://www.graphicsprings.com/filestorage/stencils/e6935e56cde852659cd5d7aa06dc261c.svg'
     }].each do |hash|
      @employer = Employer.new(hash)
      @employer.build_account(
        account_user_type: 'Empoyer',
        email: Faker::Internet.unique.email,
        password: '11111111',
        password_confirmation: '11111111'
      )
      log_errors(@employer) unless @employer.save
    end
  end
end
