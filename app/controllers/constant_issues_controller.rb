class ConstantIssuesController < ApplicationController
  def index
    # Load the first constant, trigger the chain:
    ConstantIssue
    render plain: "OK"
  end
end
