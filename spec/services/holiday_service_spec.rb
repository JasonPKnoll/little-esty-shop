require 'rails_helper'

RSpec.describe HolidayService do
  describe 'nager service' do
    before(:each) do
      @service = HolidayService.new

      @response =
      '[{
      "date": "2021-09-06",
       "localName": "Labor Day",
       "name": "Labour Day",
       "countryCode": "US",
       "types": [
       "Public"]
      },
       {
         "date": "2021-10-11",
       "localName": "Columbus Day",
       "name": "Columbus Day",
       "countryCode": "US",
       "types": [
       "Public"]
      },
       {
         "date": "2021-11-11",
       "localName": "Veterans Day",
       "name": "Veterans Day",
       "countryCode": "US",
       "types": [
       "Public"]
      },
       {
       "date": "2021-11-25",
       "localName": "Thanksgiving Day",
       "name": "Thanksgiving Day",
       "countryCode": "US",
       "fixed": false,
       "global": true,
       "counties": null,
       "launchYear": 1863,
       "types": [
       "Public"]
       }]'

      allow_any_instance_of(Faraday::Connection).to receive(:get).and_return(Faraday::Response.new)
      allow_any_instance_of(Faraday::Response).to receive(:body).and_return(@response)
    end

    it "returns next three holidays" do
      expect(HolidayService.next_three_days).to eq({"Labor Day" => "2021-09-06", "Columbus Day" => "2021-10-11", "Veterans Day" => "2021-11-11"})
    end
  end
end
