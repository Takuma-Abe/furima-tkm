class TagsController < ApplicationController
  def index
    puts "************"
    puts "タグ: #{params[:tag_name]}"
    puts "************"
    render json: {tags: []} if params[:tag_name] == ""
    tags = Tag.where(['name LIKE ?', "%#{params[:tag_name]}%"])
    render json: {tags: tags}
  end
end

# where of "?" is placeholder to put 2nd argument on "?"
# '%value%' means 'eqtn 0 string', 'value_' means '1 letter' 