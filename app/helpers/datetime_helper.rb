module DatetimeHelper
  def format_datetime(datetime)
    datetime.strftime("%m/%d/%Y %I:%M %p")
  end
end
