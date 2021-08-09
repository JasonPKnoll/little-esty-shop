require 'rails_helper'

RSpec.describe DateSwaggerService do
  before(:each) do
    @service = DateSwaggerService.new

    @response = '[{"date": "2021-09-06",
      "localName": "Labor Day",
      "name": "Labour Day",
      "countryCode": "US",
      "types": [
      "Public"]},
      {"date": "2021-10-11",
      "localName": "Columbus Day",
      "name": "Columbus Day",
      "countryCode": "US",
      "types": [
      "Public"]},
      {"date": "2021-11-11",
      "localName": "Veterans Day",
      "name": "Veterans Day",
      "countryCode": "US",
      "types": [
      "Public"]},
      {"date": "2021-11-25",
      "localName": "Thanksgiving Day",
      "name": "Thanksgiving Day",
      "countryCode": "US",
      "fixed": false,
      "global": true,
      "counties": null,
      "launchYear": 1863,
      "types": [
      "Public"]}]'

      allow_any_instance_of(Faraday::Connection).to receive(:get).and_return(Faraday::Response.new)
      allow_any_instance_of(Faraday::Response).to receive(:body).and_return(@response)
  end

  it 'returns an array' do
    expect(@service.get_holidays).to be_an(Array)
  end

  it 'returns the first 3 holidays' do
    expected = ["Labor Day", "Columbus Day", "Veterans Day"]

    expect(@service.next_three_holidays_names).to eq(expected)
  end

  it 'returns the dates of the next 3 holidays' do
    expected = ["2021-09-06", "2021-10-11", "2021-11-11"]

    expect(@service.next_three_holidays_dates).to eq(expected)
  end

  it 'returns a hash of holidays and dates' do
    expected = {
      "Labor Day" => "2021-09-06",
      "Columbus Day" => "2021-10-11",
      "Veterans Day" => "2021-11-11"
    }

    expect(@service.next_three_holidays).to eq(expected)
  end
end
