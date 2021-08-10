class HolidayService
  def self.get_days
    response = Faraday.get 'https://date.nager.at/api/v3/NextPublicHolidays/us'

    JSON.parse(response.body)
  end

  def self.next_three_days
    new_hash = {}
    get_days.take(3).map do |hash|
      new_hash[hash["localName"]] = (hash["date"])
    end
    new_hash
  end
end
