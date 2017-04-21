class SeminarsController < ApplicationController
  before_action :set_category,only:[:index]
  before_action :find_seminar, only: [:update,:show,:destroy,:edit]
  before_action :require_user, only:[:new,:edit,:destroy]
  before_action :disable_nav,only:[:landing]
  #before_action :require_owner,only:[:show]
  def landing

  end
  def index
    if @category.present?
      @seminars = Seminar.includes(:photos).where(category_id: @category)
    else
      @seminars = Seminar.all
    end
  end

  def new
    @seminar = Seminar.new
    @categories = Category.all.map{|c| [ c.name, c.id ] }
  end

  def create
    @seminar = Seminar.new(seminars_params)
    @seminar.category_id = params[:category_id]
    @seminar.user_id = current_user.id
    if @seminar.save
      if params[:images]
        params[:images].each do |image|
          @seminar.photos.create(image: image)
        end
      else
        @seminar.photos.create
      end
      redirect_to @seminar
    else
      respond_to do |format|
        format.html { render action: 'new' }
        format.json { render json: @seminar.errors, status: :unprocessable_entity }
      end
    end
  end
  def edit
    @categories = Category.all.map{|c| [ c.name, c.id ] }
  end
  def update
    if current_user.id = @seminar.user_id
      if @seminar.update_attributes(seminars_params)
        @seminar.category_id = params[:category_id]
        if params[:images]
          @seminar.photos.each do |photo|
            photo.destroy if photo.image_file_size.nil?
          end
          params[:images].each do |image|
            @seminar.photos.create(image: image)
          end
        else
          @seminar.photos.create
        end
        respond_to do |format|
          format.html { redirect_to seminar_path(@seminar), notice: 'Το σεμινάριο ενημερώθηκε επιτυχημένα' }
          format.json { head :no_content }
        end
      else
        respond_to do |format| ## Add this
          format.html { redirect_to edit_seminar_path(@seminar) }
          format.json { render json: @seminar.errors, status: :unprocessable_entity }
          format.html

        end
      end
    end
  end


  def destroy
    @seminar.destroy
    redirect_to seminars_path
  end
  private
  def find_seminar
    @seminar = Seminar.find(params[:id])
  end
  def require_user
    unless current_user
      flash[:notice] = 'Πρέπει να είστε μέλος για να έχετε πρόσβαση σε αυτή τη σελίδα'
      redirect_to signup_path
    end
  end
  def disable_nav
    @disable_nav = true
  end
  def set_category
    @category = Category.find(params[:category_id]) if params[:category_id]
  end
  def require_owner
    unless (current_user.id == Seminar.find(params[:id]).user_id && current_user.organizer != false) || current_user.admin == true
      flash[:notice] = 'Δεν έχετε δικαίωμα προσπέλασης'
      redirect_to seminars_path
    end
  end

  def seminars_params
    params.require(:seminar).permit(:title,:description,:author,:company,:price,:start_date,:end_date,:user_id,:category_id,:photos)
  end
end
