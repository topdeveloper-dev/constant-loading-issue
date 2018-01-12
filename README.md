# Constant Loading Issue

This Rails app demonstrates an issue with constant loading (and reloading). To replicate the issue:


- Clone the project & bundle install
- Boot the server with `rails s`
- Visit `/`, you should see plain text `OK`
- Open `app/models/some_namespace/another_constant.rb` and uncomment line 3
- Visit `/`, you should see a Rails error page
- Open `app/models/some_namespace/another_constant.rb` _again_ and _re_-comment line 3
- Visit `/`
- Wait ...
- Wait ...
- It never loads :S
