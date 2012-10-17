module ApplicationHelper
  def get_nav_data
    {
      'Photos' => root_path,
      'RSVP' => new_rsvp_path,
      'Events and Venues' => events_path,
      'Hotels' => hotels_path
    }
  end
end
