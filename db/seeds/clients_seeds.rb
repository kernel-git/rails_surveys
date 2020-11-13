class ClientsSeeds

  def initialize
  end

  def perform
    clients = Array.new
    [{
      label: 'BSUIR',
      email: 'kanc@bsuir.by',
      phone: '88005553535',
      address: 'Statue of Liberty, Liberty Island New York, NY 10004',
      logo_url: '¯\_(ツ)_/¯'
    },
    {
      label: 'BSU',
      email: 'bsu@bsu.by',
      phone: '88005553535',
      address: 'Statue of Liberty, Liberty Island New York, NY 10004',
      logo_url: '¯\_(ツ)_/¯'
    },
    {
      label: 'BSTU',
      email: 'rector@belstu.by',
      phone: '88005553535',
      address: 'Statue of Liberty, Liberty Island New York, NY 10004',
      logo_url: '¯\_(ツ)_/¯'
    },
    {
      label: 'BSMU',
      email: 'bsmu@bsmu.by',
      phone: '88005553535',
      address: 'Statue of Liberty, Liberty Island New York, NY 10004',
      logo_url: '¯\_(ツ)_/¯'
    },
    {
      label: 'BSAI',
      email: 'NothingHere@gmail.com',
      phone: '88005553535',
      address: 'Statue of Liberty, Liberty Island New York, NY 10004',
      logo_url: '¯\_(ツ)_/¯'
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