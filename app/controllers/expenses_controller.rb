class ExpensesController < ApplicationController
  
  before_filter :check_authentication

  def show
    @title = 'View Expense'
    @expense = Expense.find(params[:id])
  end

  def download
    @expense = Expense.find(params[:id])
    send_data(@expense.file_data, @expense.send_data_details)
  end

  def new
    @title = 'Add expense'
  end

  def create
    @expense = Expense.new(params[:expense])
    if @expense.save
      flash[:notice] = "Thank you for your submission"
      redirect_to :expenses
    else
      flash[:error] = "There was a problem with your submission"
      redirect_to new_expense_path
    end
  end

  def index
    @title = 'Expenses'
    @expenses = Expense.search_by_current_user(current_user)
  end

  def search
    @title = 'Search expenses'
    @expense = Expense.find(:first)
  end

  def search_results
    search_params = params[:expense].merge({:user => current_user})
    if @expense = Expense.search_by_expense_number(search_params)
      redirect_to expense_path(@expense)
    else
      flash[:notice] = "No expense matches your search parameters"
      redirect_to search_expenses_path
    end
  end

end
