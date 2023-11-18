require "application_system_test_case"

class CriteriaTest < ApplicationSystemTestCase
  setup do
    @criterium = criteria(:one)
  end

  test "visiting the index" do
    visit criteria_url
    assert_selector "h1", text: "Criteria"
  end

  test "should create criterium" do
    visit criteria_url
    click_on "New criterium"

    check "Leaf" if @criterium.leaf
    fill_in "Level", with: @criterium.level
    fill_in "Score", with: @criterium.score
    fill_in "Title", with: @criterium.title
    fill_in "Year", with: @criterium.year
    click_on "Create Criterium"

    assert_text "Criterium was successfully created"
    click_on "Back"
  end

  test "should update Criterium" do
    visit criterium_url(@criterium)
    click_on "Edit this criterium", match: :first

    check "Leaf" if @criterium.leaf
    fill_in "Level", with: @criterium.level
    fill_in "Score", with: @criterium.score
    fill_in "Title", with: @criterium.title
    fill_in "Year", with: @criterium.year
    click_on "Update Criterium"

    assert_text "Criterium was successfully updated"
    click_on "Back"
  end

  test "should destroy Criterium" do
    visit criterium_url(@criterium)
    click_on "Destroy this criterium", match: :first

    assert_text "Criterium was successfully destroyed"
  end
end
