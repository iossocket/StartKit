
When /I tap the login button without input anything/ do ||
  Login.click_login_button
  Login.check_error_message("User name and password can not be empty")
end