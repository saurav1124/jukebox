module ApplicationHelper

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def sec_to_mins(seconds)
    # if seconds > 3600
      # (Time.at(seconds)).strftime("%H:%M:%S")
    # else
      # (Time.at(seconds)).strftime("%H:%M:%S")
    # end
    secs = (seconds % 60)
    mins = (seconds / 60)
    if mins > 60
      hrs = mins / 60
      "%02d" % hrs + ":" + "%02d" % mins + ":" + "%02d" % secs
    else
      "%02d" % mins + ":" + "%02d" % secs
    end
  end

end
