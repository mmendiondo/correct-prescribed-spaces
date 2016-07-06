Given(/^I get "([^"]*)" with:$/) do |arg1, string|
 Browser.goto arg1 
end

Then(/^the JSON response at "([^"]*)" should be:$/) do |arg1, string|
  pending # Write code here that turns the phrase above into concrete actions
end
