class SeminarsController < ApplicationController
  respond_to :html, :json
  before_action :find_seminar, only: [:update,:show,:edit]
  #  before_action :require_user
  #  before_action :require_owner
def landing
end
  def index
      @seminars = Seminar.all
  end


  def new
    @seminar = Seminar.new 
    @categories = Category.all.map{|c| [ c.name, c.id ] }
  end

  def create
   @seminar = Seminar.new(seminars_params)
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

  def update
    if current_user.id = @seminar.user_id
      if @seminar.update_attributes(seminars_params)
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
          format.html { redirect_to @seminar, notice: 'Το σεμινάριο ενημερώθηκε επιτυχημένα' }
          format.json { head :no_content }
        end
      else
        respond_to do |format| ## Add this
          format.html { render action: 'edit' }
          format.json { render json: @seminar.errors, status: :unprocessable_entity }
          format.html

        end
      end
    end
  end


  def destroy
     @seminar = Seminar.find(params[:id])
  @seminar.destroy
   respond_to do |format|
      format.json { head :no_content }
      format.js   { render layout: false }
    end
  end
  private
  def find_seminar
    @seminar = Seminar.find(params[:id])
  end
  def require_user
    unless current_user
      flash[:notice] = 'Πρέπει να είστε μέλος για να έχετε πρόσβαση σε αυτή τη σελίδα'
      redirect_to new_user_registration_path
    end
  end


  def require_owner
    unless current_user.id == Seminar.find(params[:id]).user_id
      flash[:notice] = 'Δεν έχετε δικαίωμα προσπέλασης'
      redirect_to Seminar.find(params[:id])
    end
  end

  def seminars_params
    params.require(:seminar).permit(:title,:description,:author,:company,:price,:start_date,:end_date,:user_id,:photos)
  end
end
