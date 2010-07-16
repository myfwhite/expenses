class ExpenseController < ApplicationController
  
  before_filter :check_authentication

  def show
    @title = 'View Expense'
    @expense = Expense.find(params[:id])
  end

  def download
    @expense = Expense.find(params[:id])
    send_data(@expense.file_data,
      :filename => @expense.filename,
      :type => @expense.content_type,
      :disposition => @expense.display_type)
  end

  def new
    @title = 'Add expense'
  end

  def create
    @expense = Expense.new(params[:expense])
    #@expense.uploaded_file = params[:file]
    @expense.user = session[:user]
    @expense.expense_number = params[:expense_number]

    if @expense.save
      flash[:notice] = "Thank you for your submission"
      redirect_to :expenses
    else
      flash[:error] = "There was a problem with your submission"
    end
  end

  def index
    @title = 'Expenses'
    @expenses = Expense.find(:all, :conditions => ['user_id = ?', session[:user][:id]], :order => "created_at DESC")
  end

  def search
    @title = 'Search'
  end

  def search_results
    expense_number = params[:search][:expense_number].to_i
    @title = 'Search results'
    
    if expense_number < 1
      flash[:notice] = "Expense number cannot be blank"
      redirect_to :search_expenses
    else
      if @expense = Expense.find(:first, :conditions => ["expense_number = ?", expense_number])
        if session[:user].is_admin? || session[:user] == @expense.user
          redirect_to expense_url(@expense)
        else
          flash[:error] = "No expense file found for #{expense_number}"
          redirect_to :search_expenses
        end
      else
        flash[:notice] = "No expense file found for #{expense_number}"
        redirect_to :search_expenses
      end
    end
  end

end
