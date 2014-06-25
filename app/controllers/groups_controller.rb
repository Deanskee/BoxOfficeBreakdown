require 'open-uri'
class GroupsController < ApplicationController
  before_action :set_group, :only => [:show, :edit, :update, :destroy]

  respond_to :json, :html

def index
    @groups = Group.all
    
# Scraping that calls the css class wrap for title and weekend amount and iterates from the top 5 for the weekend
    url = "https://search.yahoo.com/search?p=movie+weekend+box+office&toggle=1&cop=mss&ei=UTF-8&fr=yfp-t-901"
    doc = Nokogiri::HTML(open(url))

    listings = Array.new

  
    doc.css(".wrap").each do |item|
      @title = item.at_css(".c-styl-5").text
      # so we have a title
      dot_idx = @title.index(". ")
      # below calls the actual amount from the scrape and stores it in the actual amount under movies model. 
      if dot_idx && dot_idx >= 0
        puts "*********** " + @title.inspect
        this_movie = Movie.where("title like ?", "%"+@title[(dot_idx + 2)..-1]).first
        @box = item.at_css(".c-styl-8").text
         puts "we found it!" + @title + "x"
         # Needed to take out the $, the , and the . symbol from the scrape so it would store the actual weekend box office amount
        if this_movie

          this_movie.actual_amount = @box.gsub('$', '').gsub(',', '').to_i
          this_movie.save

        end
        listings << [@title, @box]
      end
end
    @listings = listings[0..4]
    # This takes the top 5 from the weekend box office amount

    # Below is comparing the guess amount from the week prior to the actual amount and sorting the guesses stored as a and b
    last_week= Guess.where( :created_at => Date.commercial(Date.today.year, Date.today.cweek - 1, 1) ... Date.commercial(Date.today.year, Date.today.cweek, 1))

     last_week.sort {|a,b| (a.movie.actual_amount - a.amount).abs <  (b.movie.actual_amount - b.amount).abs}
      # raise last_week.map(&:id).inspect
end


  def show

    respond_with @group
  end

  def edit
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)

    if @group.save
      respond_to do |format|
        flash[:success] = "Group successfully created"
        format.html { redirect_to group_path(@group) }
        format.json { render json: @group, status: :created }
      end
    else
      respond_to do |format|
        flash[:danger] = "Group could not be created!"
        format.html { render 'new' }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def update

    if @group.update(group_params)
      respond_to do |format|
        format.html { redirect_to group_path(@group) }
        format.json { render nothing: true, status: :no_content }
      end
    else
      respond_to do |format|
        format.html { render 'edit' }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy

    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_path }
      format.json { render json: :no_content }
    end
  end

  protected

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :description, :avatar_file_name, :avatar_content_type, :avatar_file_size, :avatar, :user_ids => [])
  end

end
