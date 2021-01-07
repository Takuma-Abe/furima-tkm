class TagsController < ApplicationController
  def index
    puts "************"
    puts "タグ: #{params[:tag_name]}"
    puts "************"
    return render json: {tags: [] } if params[:tag_name] == "" 
    tags = Tag.where(['name LIKE ?', "%#{params[:tag_name]}%"])
    render json: {tags: tags}
  end
end

# "?" in where is placeholder to put 2nd argument on "?"
# '%value%' means 'eqtn 0 string', 'value_' means '1 letter' 