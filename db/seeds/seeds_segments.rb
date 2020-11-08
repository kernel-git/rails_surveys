segments = Array.new
[{
    label: 'Teacher'
},
{
    label: 'Technical'
},
{
    label: 'Management'
},
{
    label: 'Bachelor Student'
},
{
    label: 'Master Student'
},
{
    label: 'Ph D Student'
}].each { |hash| segments << Segment.new(hash) }

segments[0].clients << Client.find_by(label: 'BSUIR')
segments[0].clients << Client.find_by(label: 'BSTU')
segments[0].clients << Client.find_by(label: 'BSAI')
segments[1].clients << Client.find_by(label: 'BSTU')
segments[1].clients << Client.find_by(label: 'BSMU')
segments[2].clients << Client.find_by(label: 'BSUIR')
segments[2].clients << Client.find_by(label: 'BSU')
segments[2].clients << Client.find_by(label: 'BSTU')
segments[2].clients << Client.find_by(label: 'BSMU')
segments[2].clients << Client.find_by(label: 'BSAI')
segments[3].clients << Client.find_by(label: 'BSTU')
segments[3].clients << Client.find_by(label: 'BSU')
segments[4].clients << Client.find_by(label: 'BSMU')
segments[4].clients << Client.find_by(label: 'BSTU')
segments[5].clients << Client.find_by(label: 'BSUIR')

begin
    segments.each(&:save!)
rescue => e
    puts '--->EXEPTION DURING SAVE<---'
    puts "Exeption type: #{e.class.name}"
    puts "Exeption message: #{e.message}"
    puts '~~~~~~~Stack trace~~~~~~~'
    e.backtrace.each { |line| puts line }
    puts '~~~~~~~~~~~~~~~~~~~~~~~~~'
end