# (3.5)edit部分
def edit
  @id_comment = OtherComment.find(params[:id]).id
end


#(7.5)update部分
def update
  @other_comment = OtherComment.find(params[:id])
  if @other_comment.update(other_comment: params[:other_comment][:other_comment])
    @id_comment = @other_comment.id
  else
    @status = 'fail'
  end
end
