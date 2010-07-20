class Expense < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :expense_number, :user, :filename
  validates_associated :user
  validates_numericality_of :expense_number

  def authorised_for?(current_user)
    true if (current_user.is_admin? || user == current_user)
  end
  
  def self.search_by_current_user(user)
    search_by_user(user,user)
  end

  # admin users can view any other users' expenses
  # other users can only view their own expenses
  def self.search_by_user(user,current_user)
    if current_user.is_admin? || user = current_user
      find_all_by_user_id(user.id, :order => "created_at DESC")
    end
  end

  # given params with an expense_number and the current user
  # return the expense with that expense number.
  # if it doesn't exist, or the current_user is not authorised, then
  # return nil
  def self.search_by_expense_number(params)
    return nil unless params[:expense_number]
    expense = find_by_expense_number(params[:expense_number])
    expense if expense && expense.authorised_for?(params[:user])
  end

  def display_type
    @inline_types = ['application/pdf', 'text/plain', 'image/gif', 'image/jpeg', 'image/png']
    @inline_types.each do |type|
      return 'inline' if type == self.content_type
    end
    'downloaded'
  end

  def send_data_details
    {:filename => this.filename, :type => this.content_type, :disposition => this.display_type}
  end

  def uploaded_file=(incoming_file)
    self.filename = incoming_file.original_filename
    self.content_type = incoming_file.content_type
    self.file_data = incoming_file.read
  end

  def filename=(new_filename)
    write_attribute("filename", sanitize_filename(new_filename))
  end

  private

  def sanitize_filename(filename)
    just_filename = File.basename(filename)
    just_filename.gsub(/[^\w\.\-]/, '_')
  end

end
