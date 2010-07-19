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
    end
  end

  def index
    @title = 'Expenses'
    Expense.search({:user => current_user})
  end

  def search
    @title = 'Search expenses'
  end

end
