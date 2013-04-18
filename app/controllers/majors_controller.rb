class MajorsController < ApplicationController
  # GET /majors
  # GET /majors.json
  def index
    @majors = Major.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @majors }
    end
  end

  # GET /majors/1
  # GET /majors/1.json
  def show
    @major = Major.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @major }
    end
  end

  # GET /majors/new
  # GET /majors/new.json
  def new
    @major = Major.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @major }
    end
  end

  # GET /majors/1/edit
  def edit
    @major = Major.find(params[:id])
  end

  # POST /majors
  # POST /majors.json
  def create
    if !params[:user_id].blank?
      @major = Major.find(params[:major][:id])
      unless current_user.majors.include?(@major)
        unless current_user.has_role? :admin
          current_user.majors << @major
        end
        redirect_to user_path(current_user), notice: 'Added major to your profile!'
      else
        redirect_to user_path(current_user), notice: 'You already have this major!'
      end
    end
  end

  # PUT /majors/1
  # PUT /majors/1.json
  def update
    @major = Major.find(params[:id])

    respond_to do |format|
      if @major.update_attributes(params[:major])
        format.html { redirect_to @major, notice: 'Major was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @major.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /majors/1
  # DELETE /majors/1.json
  def destroy
    @major = Major.find(params[:id])
    @major.destroy

    respond_to do |format|
      format.html { redirect_to majors_url }
      format.json { head :no_content }
    end
  end
end
