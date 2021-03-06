class TagsController < ApplicationController
  def index
    render json: Tag.all
  end

  def show
    @tag = Tag.find_by(id: params[:id])
    impressionist(@tag, 'TagController', :unique => [:session_hash])
  end
end
