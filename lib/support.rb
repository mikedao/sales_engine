require 'date'

module Support
  def date_scrubber(data)
    Date.parse(data).to_s
  end
end
