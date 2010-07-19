class Expense < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :expense_number, :user, :filename
  validates_associated :user
  validates_numericality_of :expense_number

  def self.search(search_params)
    if search_params[:user]
      find_all_by_user_id(search_params[:user].id, :order => "created_at DESC")
    end
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
