class Employee::EmployeesController < ApplicationController
  layout 'employee'
  before_action :check_account_type, if: :authenticate_account!

  def show
    puts "Ping from employee/employees#show with params: #{params}"
  end
  def edit
    puts "Ping from employee/employees#edit with params: #{params}"
  end
  def update
    puts "Ping from employee/employees#update with params: #{params}"
  end

  protected

  def check_account_type
    redirect_to(not_found_404_path) unless current_account.account_type == 'employee'
  end

end
