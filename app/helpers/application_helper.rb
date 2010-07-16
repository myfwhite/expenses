# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def heading
    @title.nil? ? "" : @title
  end

  def title
    @title.nil? ? "C3 Expense Files" : "C3 Expense Files | #{@title}"
  end
  
end
