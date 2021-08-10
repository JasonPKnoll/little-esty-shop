require 'rails_helper'

RSpec.describe 'Merchant discounts index page' do
  describe "index" do

    before(:each) do
      @discounts = []
      @merchant_1 = create(:merchant)
      3.times do
        @discounts << create(:discount, merchant_id: @merchant_1.id)
      end
    end

    it "I see all discounts for this merchant" do
      visit "merchants/#{@merchant_1.id}/discounts"

      expect(page).to have_content(@discounts.first.percentage)
      expect(page).to have_content(@discounts.first.threshold)

      expect(page).to have_content(@discounts.second.percentage)
      expect(page).to have_content(@discounts.second.threshold)

      expect(page).to have_content(@discounts.third.percentage)
      expect(page).to have_content(@discounts.third.threshold)
    end

    it "has a link for each discount to its show page" do
      visit "merchants/#{@merchant_1.id}/discounts"

      within "#discount-#{@discounts.first.id}" do
        click_link "#{@discounts.first.percentage}% Discount"
      end

      expect(current_path).to eq("/merchants/#{@merchant_1.id}/discounts/#{@discounts.first.id}")
    end

    it "has a link to create a new discount" do
      visit "merchants/#{@merchant_1.id}/discounts"

      click_link "Create Discount"

      expect(current_path).to eq("/merchants/#{@merchant_1.id}/discounts/new")
    end

    it "can create a new discount" do
      visit "merchants/#{@merchant_1.id}/discounts"

      click_link "Create Discount"

      fill_in :percentage, with: 90.5
      fill_in :threshold, with: 100

      click_button "Submit"

      expect(current_path).to eq("/merchants/#{@merchant_1.id}/discounts")

      expect(page).to have_content(90)
      expect(page).to have_content(100)
    end

    it "should flash success when creating a discount succesfully" do
      visit "merchants/#{@merchant_1.id}/discounts"

      click_link "Create Discount"

      fill_in :percentage, with: 90.5
      fill_in :threshold, with: 100

      click_button "Submit"

      expect(page).to have_content("Success: New discount has been created!")
    end

    it "can delete each discount" do
      visit "merchants/#{@merchant_1.id}/discounts"

      within "#discount-#{@discounts.first.id}" do
        click_link "Delete this discount"
      end

      within "#discount-#{@discounts.second.id}" do
        click_link "Delete this discount"
      end

      within "#discount-#{@discounts.third.id}" do
        click_link "Delete this discount"
      end

      expect(page).to_not  have_content(" #{@discounts.first.percentage} ")
      expect(page).to_not  have_content(" #{@discounts.second.percentage} ")
      expect(page).to_not  have_content(" #{@discounts.third.percentage} ")

      expect(page).to_not  have_content(" #{@discounts.first.threshold} ")
      expect(page).to_not  have_content(" #{@discounts.second.threshold} ")
      expect(page).to_not  have_content(" #{@discounts.third.threshold} ")
    end

    describe "Holidays" do
      # before(:each, :holiday) do
      #   @service = HolidayService.new
      #
      #   @response =
      #   '[{
      #   "date": "2021-09-06",
      #    "localName": "Labor Day",
      #    "name": "Labour Day",
      #    "countryCode": "US",
      #    "types": [
      #    "Public"]
      #   },
      #    {
      #      "date": "2021-10-11",
      #    "localName": "Columbus Day",
      #    "name": "Columbus Day",
      #    "countryCode": "US",
      #    "types": [
      #    "Public"]
      #   },
      #    {
      #      "date": "2021-11-11",
      #    "localName": "Veterans Day",
      #    "name": "Veterans Day",
      #    "countryCode": "US",
      #    "types": [
      #    "Public"]
      #   },
      #    {
      #    "date": "2021-11-25",
      #    "localName": "Thanksgiving Day",
      #    "name": "Thanksgiving Day",
      #    "countryCode": "US",
      #    "fixed": false,
      #    "global": true,
      #    "counties": null,
      #    "launchYear": 1863,
      #    "types": [
      #    "Public"]
      #    }]'
      #
      #   allow_any_instance_of(Faraday::Connection).to receive(:get).and_return(Faraday::Response.new)
      #   allow_any_instance_of(Faraday::Response).to receive(:body).and_return(@response)
      # end

      it "shows the Upcoming holidays names", :holiday do
        visit "merchants/#{@merchant_1.id}/discounts"

        expect(page).to have_content("Labor Day")
        expect(page).to have_content("Columbus Day")
        expect(page).to have_content("Veterans Day")
      end

      it "shows the Upcoming holidays dates", :holiday do
        visit "merchants/#{@merchant_1.id}/discounts"

        expect(page).to have_content("2021-09-06")
        expect(page).to have_content("2021-10-11")
        expect(page).to have_content("2021-11-11")
      end
    end
  end
end
