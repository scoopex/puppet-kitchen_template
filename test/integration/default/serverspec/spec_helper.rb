require 'serverspec'

# format kitchen-test spec output for Jenkins
require 'yarjuf'

RSpec.configure do |c|

    c.formatter = 'JUnit'

end
