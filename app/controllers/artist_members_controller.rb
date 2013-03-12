class ArtistMembersController < ApplicationController
  # GET /artist_members
  # GET /artist_members.json
  def index
    @artist_members = ArtistMember.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @artist_members }
    end
  end

  # GET /artist_members/1
  # GET /artist_members/1.json
  def show
    @artist_member = ArtistMember.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @artist_member }
    end
  end

  # GET /artist_members/new
  # GET /artist_members/new.json
  def new
    @artist_member = ArtistMember.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @artist_member }
    end
  end

  # GET /artist_members/1/edit
  def edit
    @artist_member = ArtistMember.find(params[:id])
  end

  # POST /artist_members
  # POST /artist_members.json
  def create
    @artist_member = ArtistMember.new(params[:artist_member])

    respond_to do |format|
      if @artist_member.save
        format.html { redirect_to @artist_member, notice: 'Artist member was successfully created.' }
        format.json { render json: @artist_member, status: :created, location: @artist_member }
      else
        format.html { render action: "new" }
        format.json { render json: @artist_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /artist_members/1
  # PUT /artist_members/1.json
  def update
    @artist_member = ArtistMember.find(params[:id])

    respond_to do |format|
      if @artist_member.update_attributes(params[:artist_member])
        format.html { redirect_to @artist_member, notice: 'Artist member was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @artist_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /artist_members/1
  # DELETE /artist_members/1.json
  def destroy
    @artist_member = ArtistMember.find(params[:id])
    @artist_member.destroy

    respond_to do |format|
      format.html { redirect_to artist_members_url }
      format.json { head :no_content }
    end
  end
end
