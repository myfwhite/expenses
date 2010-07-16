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
    @expense = Expense.new
    @expense.uploaded_file = params[:new][:file]
    @expense.user_id = session[:user][:id]
    @expense.expense_number = params[:new][:expense_number]

    if @expense.save
      flash[:notice] = "Thank you for your submission"
      redirect_to :action => "index"
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
      redirect_to :action => 'search'
    else
      if @expense = Expense.find(:first, :conditions => ["expense_number = ?", expense_number])
        if session[:user][:is_admin] || session[:user][:id] == @expense[:user_id]
          redirect_to :action => 'show', :id => @expense.id
        else
          flash[:error] = "No expense file found for #{expense_number}"
          redirect_to :action => 'search'
        end
      else
        flash[:notice] = "No expense file found for #{expense_number}"
        redirect_to :action => 'search'
      end
    end
  end

end
