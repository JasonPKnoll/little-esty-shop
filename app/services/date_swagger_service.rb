class DateSwaggerService
  def get_holidays
    response = Faraday.get 'https://date.nager.at/api/v3/NextPublicHolidays/us'

    JSON.parse(response.body)
  end

  def next_three_holidays_names
    names = get_holidays.map do |hash|
      hash["localName"]
    end
    names[0..2]
  end

  def next_three_holidays_dates
    dates = get_holidays.map do |hash|
      hash["date"]
    end
    dates[0..2]
  end

  def next_three_holidays
    Hash[next_three_holidays_names.zip(next_three_holidays_dates)]
  end
end
