class Admin::EventCommentsController < ApplicationController
  def index
    @event_comments = EventComment.all
  end
end
