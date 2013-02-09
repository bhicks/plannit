module ApplicationHelper
  def format_mdy(date)
    date ? date.strftime("%m/%d/%Y") : ''
  end
end
