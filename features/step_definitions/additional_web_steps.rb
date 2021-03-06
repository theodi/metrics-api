require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

Given /^I am logged in as "([^\"]*)" with "([^\"]*)"$/ do |user,pwd|
  page.driver.browser.basic_authorize user, pwd
end

When /^I click the button "([^\"]*)"$/ do |id|
  click_button(id)
end

When /I populate a field "([^\"]*)" with "([^\"]*)"$/ do |field, content|
  fill_in(field, with: content)
end

When /^I select "([^\"]*)" from field "([^\"]*)" in the table "([^\"]*)"$/ do |value, field, table|
  within_table(table) do
    select(value, :from => field)
  end
end

Then /^the page should contain an element "([^\"]*)"$/ do | element |
  expect(page.find(element)).to_not be(nil)
end

Then /^the page should contain an element with id "([^\"]*)"$/ do | id |
  expect(page.find("##{id}")).to_not be(nil)
end

Then /^the form should contain a field "([^\"]*)"$/ do |field|
  expect(find_field(field)).to_not be(nil)
end

Then /^the form field "([^\"]*)" should contain a value "([^\"]*)"$/ do |field_id, contents|
  expect(find_field(field_id).value).eql?(contents)
end