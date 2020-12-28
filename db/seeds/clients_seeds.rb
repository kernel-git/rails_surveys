class ClientsSeeds

  def initialize
  end

  def perform
    clients = Array.new
    [{
      label: 'BSUIR',
      email: 'kanc@bsuir.by',
      password: '11111111',
      phone: '88005553535',
      address: 'Statue of Liberty, Liberty Island New York, NY 10004',
      logo_url: 'https://www.graphicsprings.com/filestorage/stencils/29c2824f9ba81b8e219075f347cf5e6b.svg'
    },
    {
      label: 'BSU',
      email: 'bsu@bsu.by',
      password: '11111111',
      phone: '88005553535',
      address: 'Statue of Liberty, Liberty Island New York, NY 10004',
      logo_url: 'https://www.graphicsprings.com/filestorage/stencils/d815a666e1de0fb6c31f76574c33cbf7.svg'
    },
    {
      label: 'BSTU',
      email: 'rector@belstu.by',
      password: '11111111',
      phone: '88005553535',
      address: 'Statue of Liberty, Liberty Island New York, NY 10004',
      logo_url: 'https://www.graphicsprings.com/filestorage/stencils/1aed58b953d14e20bb583a893d057e5c.svg'
    },
    {
      label: 'BSMU',
      email: 'bsmu@bsmu.by',
      password: '11111111',
      phone: '88005553535',
      address: 'Statue of Liberty, Liberty Island New York, NY 10004',
      logo_url: 'https://www.graphicsprings.com/filestorage/stencils/837d16f76770c867a23c1857fae9c39c.svg'
    },
    {
      label: 'BSAI',
      email: 'NothingHere@gmail.com',
      password: '11111111',
      phone: '88005553535',
      address: 'Statue of Liberty, Liberty Island New York, NY 10004',
      logo_url: 'https://www.graphicsprings.com/filestorage/stencils/e6935e56cde852659cd5d7aa06dc261c.svg'
    }].each { |hash| clients << Client.new(hash) }

    begin
      clients.each(&:save!)
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved => e
      puts '--->EXEPTION DURING SAVE<---'
      puts "Exeption type: #{e.class.name}"
      puts "Exeption message: #{e.message}"
      puts '~~~~~~~Stack trace~~~~~~~'
      e.backtrace.each { |line| puts line }
      puts '~~~~~~~~~~~~~~~~~~~~~~~~~'
    end
  end
end