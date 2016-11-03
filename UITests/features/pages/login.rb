require 'test-unit'
class Login
  def self.click_login_button
    driver.find_element(:name, 'Login').click
  end

  def self.check_error_message(errorMessage)
    driver.find_element(:name, errorMessage)
  end
end


