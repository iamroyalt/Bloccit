module TopicsHelper
  def user_is_authorized_for_topics?
<<<<<<< HEAD
          current_user && current_user.admin?
     end
=======
        current_user && current_user.admin?
   end
>>>>>>> Checkpoint-40
end
#Rails helpers are automatically available to their corresponding views.
#This means that methods defined in TopicsHelper will be available in all the topic views.
