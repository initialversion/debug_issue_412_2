class LikesController < ApplicationController
  before_action :current_user_must_be_like_user, :only => [:edit, :update, :destroy]

  def current_user_must_be_like_user
    like = Like.find(params[:id])

    unless current_user == like.user
      redirect_to :back, :alert => "You are not authorized for that."
    end
  end

  def index
    @likes = Like.page(params[:page])

    render("likes/index.html.erb")
  end

  def show
    @like = Like.find(params[:id])

    render("likes/show.html.erb")
  end

  def new
    @like = Like.new

    render("likes/new.html.erb")
  end

  def create
    @like = Like.new

    @like.user_id = params[:user_id]
    @like.photo_id = params[:photo_id]

    save_status = @like.save

    if save_status == true
      redirect_to(:back, :notice => "Like created successfully.")
    else
      render("likes/new.html.erb")
    end
  end

  def edit
    @like = Like.find(params[:id])

    render("likes/edit.html.erb")
  end

  def update
    @like = Like.find(params[:id])

    @like.user_id = params[:user_id]
    @like.photo_id = params[:photo_id]

    save_status = @like.save

    if save_status == true
      redirect_to(:back, :notice => "Like updated successfully.")
    else
      render("likes/edit.html.erb")
    end
  end

  def destroy
    @like = Like.find(params[:id])

    @like.destroy

    redirect_to(:back, :notice => "Like deleted.")
  end
end
