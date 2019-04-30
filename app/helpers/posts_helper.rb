module PostsHelper
  def choose_new_or_edit
    if action_name == "new" || action_name == "confirm"
      confirm_group_posts_path
    elsif action_name == "edit"
      group_post_path
    end
  end
end
