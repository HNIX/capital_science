require "application_system_test_case"

class ListingsTest < ApplicationSystemTestCase
  setup do
    @listing = listings(:one)
  end

  test "visiting the index" do
    visit listings_url
    assert_selector "h1", text: "Listings"
  end

  test "creating a Listing" do
    visit listings_url
    click_on "New Listing"

    fill_in "Title", with: @listing.title
    fill_in "User", with: @listing.user_id
    click_on "Create Listing"

    assert_text "Listing was successfully created"
    assert_selector "h1", text: "Listings"
  end

  test "updating a Listing" do
    visit listing_url(@listing)
    click_on "Edit", match: :first

    fill_in "Title", with: @listing.title
    fill_in "User", with: @listing.user_id
    click_on "Update Listing"

    assert_text "Listing was successfully updated"
    assert_selector "h1", text: "Listings"
  end

  test "destroying a Listing" do
    visit edit_listing_url(@listing)
    click_on "Delete", match: :first
    click_on "Confirm"

    assert_text "Listing was successfully destroyed"
  end
end
