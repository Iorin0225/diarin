module DatetimeHelper
  def format_datetime(datetime)
    datetime.strftime("%Y-%m-%d %H:%M:%S")
  end

  def date_only(datetime)
    datetime.strftime("%Y-%m-%d")
  end
end
